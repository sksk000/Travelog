FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10) }
    body  { Faker::Lorem.characters(number:30) }
    good  { Faker::Number.between(from: 0, to: 5)}
    season{ Faker::Number.between(from: 0, to: 3)}
    place { Faker::Number.between(from: 0, to: 1)}
    night { Faker::Number.between(from: 0, to: 4)}
    people{ Faker::Number.between(from: 0, to: 4)}
    association :user
  end
end