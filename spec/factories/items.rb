FactoryBot.define do
  factory :item do
    name         { Faker::Name.name }
    description  { Faker::Lorem.sentence }
    price        { Faker::Number.number(digits: 5) }
    category_id        { 3 }
    condition_id       { 2 }
    handling_time_id   { 2 }
    delivery_charge_id  { 2 }
    prefecture_id       { 2 }
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
