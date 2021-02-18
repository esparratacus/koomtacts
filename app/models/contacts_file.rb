# frozen_string_literal: true

require 'csv'
class ContactsFile < ApplicationRecord
  max_paginates_per 10
  mount_uploader :contacts, ContactsUploader

  has_many :importer_logs, dependent: :destroy

  PENDING         = 'PENDING'.freeze
  PROCESSING      = 'PROCESSING'.freeze
  FAILED          = 'FAILED'.freeze
  FINISHED        = 'FINISHED'.freeze
  IMPORT_STATUSES = [PENDING, PROCESSING, FAILED, FINISHED].freeze

  validates_presence_of :contacts
  validates :status, inclusion: { in: IMPORT_STATUSES }, allow_nil: true
  before_create :set_pending_status

  def contact_file_headers
    f = CSV.open(contacts.current_path, headers: true).read
    f.headers
  end

  def import_contacts
    importer_logs.destroy_all
    update(status: PROCESSING)
    CSV.foreach(contacts.current_path, headers: true) do |row|
      contact = row.to_hash
      new_contact = Contact.new(user_id: user_id,
                                name: contact[header_mappings['name']],
                                dob: contact[header_mappings['dob']],
                                address: contact[header_mappings['address']],
                                email: contact[header_mappings['email']],
                                cc_number: contact[header_mappings['cc_number']],
                                phone_number: contact[header_mappings['phone_number']])

      importer_logs.create(candidate: contact, error_log: new_contact.errors.messages) unless new_contact.save
    end
    contact_count == importer_logs.count ? update(status: FAILED) : update(status: FINISHED)
  end

  def contact_count
    self[:contacts].nil? ? 0 : CSV.foreach(contacts.current_path, headers: true).count
  end

  private

  def set_pending_status
    self.status = PENDING
  end
end
