FactoryBot.define do
  factory :order_shipping do
    post_code { '123-4567' }
    prefecture_id { 1 }
    municipalities { '千代田区' }
    street_address { '一番町1-1' }
    building_name { 'ブリリア一番町8888' }
    telephone_number { '09090908080' }
    # token {"tok_abcdefghijk00000000000000000"}

    association :user_id
    association :item_id
  end
end
