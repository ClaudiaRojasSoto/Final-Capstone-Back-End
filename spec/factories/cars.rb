FactoryBot.define do
  factory :car do
    name { "Modelo de coche #{Faker::Vehicle.make_and_model}" }
    description { Faker::Vehicle.standard_specs.join(', ') }
    deposit { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    finance_fee { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    option_to_purchase_fee { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    total_amount_payable { deposit + finance_fee + option_to_purchase_fee }
    duration { Faker::Number.between(from: 1, to: 5) }
    removed { [true, false].sample }

    trait :available do
      removed { false }

      after(:create) do |car, _evaluator|
        car.reservations.destroy_all
      end
    end
  end
end
