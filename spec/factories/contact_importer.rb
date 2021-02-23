FactoryBot.define do
  factory :contact_importer, class: Imports::ContactImporter do
    skip_create
    contacts_file
  end
end