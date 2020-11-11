FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname               { Faker::Name.initials(number: 2) }
    email                  { Faker::Internet.free_email }
    password               { 'hm19860904' }
    password_confirmation  { 'hm19860904' }
    first_name             { person.first.kanji }
    last_name              { person.last.kanji }
    first_name_kana        { person.first.katakana }
    last_name_kana         { person.last.katakana }
    birth_date             { Faker::Date.birthday(min_age: 5, max_age: 90) }
  end
end
