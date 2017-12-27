FactoryGirl.define do
  factory :comment do
    association :user
    association :movie
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence(3, true) }
    created_at { Time.now.utc }
    sequence(:movie_id) { |n| n }
  end
end