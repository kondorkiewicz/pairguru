FactoryGirl.define do
  factory :movie do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre

    trait :with_comments do
      after(:create) do |movie|
        create_list :comment, 5, movie: movie
      end
    end
  end
end
