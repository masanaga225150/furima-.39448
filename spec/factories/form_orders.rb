FactoryBot.define do
  factory :form_order do
    delivery_zipcode { Faker::Number.decimal_part(digits: 3) + '-' + Faker::Number.decimal_part(digits: 4) }
    delivery_prefecture_id { Faker::Number.between(from: 2, to: 48) }
    delivery_city { Faker::Address.city }
    delivery_address { Faker::Address.street_address }
    delivery_building { Faker::Address.street_address }
    delivery_phone { Faker::Number.decimal_part(digits: 11) }
    token { Faker::Internet.password(min_length: 20, max_length: 30) }
  end
end
