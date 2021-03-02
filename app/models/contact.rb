class Contact < ApplicationRecord
  belongs_to :user
  max_paginates_per 10
  validates_presence_of :name, :dob, :address, :email
  validates_format_of :phone_number, with: /\(\+\d{2,3}\) \d{3}(?: \d{3} \d{2} \d{2}|\-\d{3}\-\d{2}\-\d{2})/
  validates_format_of :dob, with: /\d{4}\-\d{2}\-\d{2}/
  validates :cc_number, presence: true, credit_card_number: true, on: :create
  after_validation :set_cc_fields

  private

  def set_cc_fields
    detector = CreditCardValidations::Detector.new(cc_number)
    self.franchise = detector.brand
    self.cc_4_digits = cc_number.chars.last(4).join("")
    self.cc_number = Digest::SHA256.base64digest cc_number
  end
end
