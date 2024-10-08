FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    name                  { "test"}
    introduction          { "aaaaa" }
  end
end