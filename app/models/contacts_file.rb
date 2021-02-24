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
    f = CSV.parse(contacts_csv.download, headers: true, encoding: 'UTF-8')
    f.headers
  end

  private

  def set_pending_status
    self.status = ContactsFile::PENDING
  end
end
