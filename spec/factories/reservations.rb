FactoryBot.define do
  factory :reservation do
    car
    user
    city { Faker::Address.city }
    start_time { Time.now + 1.day }
    end_time { Time.now + 2.days }
  end
end
