FactoryBot.define do
  factory :customer do
    post_code     { '245-0018' }
    city          { '神奈川' }
    building_name { '青山ハイツ' }
    house_number  { '123-4567' }
    prefecture_id { 2 }
    phone_number  { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
