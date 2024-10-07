FactoryBot.define do
  factory :user do
    email { "aaa@bbb" }
    password              { "qweerty" }
    password_confirmation { "qweerty" }
    name                  { "test"}
    introduction          { "aaaaa" }
  end
end