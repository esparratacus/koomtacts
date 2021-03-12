class ContactsFileSerializer
  include JSONAPI::Serializer
  attributes :status, :file_name,:header_mappings
  belongs_to :user
end
