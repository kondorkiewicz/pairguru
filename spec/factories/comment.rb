FactoryGirl.define do
  factory :comment do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence(3, true) }
    created_at { Time.now.utc }
    user_id 1
    sequence(:movie_id) { |n| n }
  end
end