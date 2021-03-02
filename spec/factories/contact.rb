FactoryBot.define do
  factory :contact do
    name { Faker::Name.name}
    dob {Faker::Date.birthday(min_age: 18)}
    address { Faker::Address.full_address }
    cc_number { '4111111111111111' }
    email { Faker::Internet.email }
    phone_number { '(+57) 322-942-77-98' }
    user
  end
end