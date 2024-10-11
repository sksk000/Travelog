FactoryBot.define do
  factory :place do
    place_name {Faker::Lorem.characters(number:10)}
    address {Faker::Lorem.characters(number:10)}
    comment{Faker::Lorem.characters(number:10)}
    post
  end
end