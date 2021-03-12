class ContactSerializer
  include JSONAPI::Serializer
  attributes :name, :dob,:phone_number,:address,:cc_4_digits, :franchise,:email
  belongs_to :user
end
