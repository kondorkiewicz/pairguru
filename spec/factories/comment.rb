FactoryGirl.define do
  factory :comment do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence(3, true) }
    created_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    user
  end
end