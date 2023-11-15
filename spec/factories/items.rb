FactoryBot.define do
  factory :item do
    product_name          {Faker::Name.product_name}
    product_description   {Faker::Internet.email}
    category_id           {'000aaa'}
    product_condition_id  {password}
    delivery_charge_id             {'焼肉'}
    prefecture_id            {'太郎'}
    shipping_day_id        {'ヤキニク'}
    price                  {'タロウ'}
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
