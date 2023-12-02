FactoryBot.define do
  factory :order_shipping do
    post_code { '123-1212' }
    prefecture_id { '1' }
    municipalities { '千代田区' }
    street_address { '一番町１－１' }
    building_name { 'ブリリアタワー１番町' }
    telephone_number { '09099998888' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end
