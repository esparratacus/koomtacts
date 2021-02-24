FactoryBot.define do
  factory :contacts_file,class: ContactsFile do
    contacts_csv { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/contacts_test.csv".force_encoding("UTF-8"), 'text/csv') }
    header_mappings {
      { name: 'nombre',
      dob: 'fecha de nacimiento',
      address: 'dirección',
      email: 'correo',
      cc_number: 'tarjeta',
      phone_number: 'teléfono' }
    }
    user
    trait :contacts_file_with_errors do
      contacts_csv { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/contacts_test_with_errors.csv".force_encoding("UTF-8"), 'text/csv') }
    end
    trait :valid_objects do
      contacts_csv { Rack::Test::UploadedFile.new("#{Rails.root}/spec/support/contacts_test.csv".force_encoding("UTF-8"), 'text/csv') }
    end
  end
end
