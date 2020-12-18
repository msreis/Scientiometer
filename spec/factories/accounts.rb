FactoryBot.define do
  factory :account do
    username { Faker::Name.first_name }
    password { '123' }
    employee_id { create(:employee).id }
    profile
  end
end
