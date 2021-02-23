# frozen_string_literal: true

require 'csv'
class ContactsFile < ApplicationRecord
  max_paginates_per 10

  alias_attribute :file_name,:contacts
  belongs_to :user
  has_many :importer_logs, dependent: :destroy
  has_one_attached :contacts_csv
  validates :contacts_csv, presence: true

  PENDING         = 'PENDING'.freeze
  PROCESSING      = 'PROCESSING'.freeze
  FAILED          = 'FAILED'.freeze
  FINISHED        = 'FINISHED'.freeze
  IMPORT_STATUSES = [PENDING, PROCESSING, FAILED, FINISHED].freeze
  HEADER_COLUMNS = %i[name dob address email cc_number phone_number].freeze

  validates :status, inclusion: { in: IMPORT_STATUSES }, allow_nil: true
  before_create :set_pending_status

  def contact_file_headers
    f = CSV.open(contacts.current_path, headers: true).read
    f.headers
  end

  def import_contacts
    raise Exceptions::HeaderMappingsNotSetException, 'Header Mappings not set' unless header_mappings

    importer_logs.destroy_all
    update(status: PROCESSING)

    processed_all? ? update(status: FINISHED) : update(status: FAILED)
  end

  private

  def processed_all?(counter: 0, failed_counter: 0)
    CSV.parse(contacts_csv.download, headers: true, encoding: 'UTF-8') do |row|
      counter += 1
      csv_line = row.to_hash
      new_contact = new_contact_from_csv(csv_line)
      next if new_contact.save

      importer_logs.create(candidate: csv_line, error_log: new_contact.errors.messages)
      failed_counter += 1
    end
    failed_counter != counter
  end

  def new_contact_from_csv(csv_line)
    Contact.new(user_id: user_id).tap do |new_contact|
      HEADER_COLUMNS.each { |col| new_contact[col] = csv_line[header_mappings[col.to_s]] }
    end
  end

  def set_pending_status
    self.status = PENDING
  end
end
