FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    first_name            { Faker::Japanese::Name.first_name }
    last_name             { Faker::Japanese::Name.last_name }
    first_name_kana       { 'ユタカ' }
    last_name_kana        { 'タナカ' }
    birthday              { Faker::Date.birthday }
  end
end
