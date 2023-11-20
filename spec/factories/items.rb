FactoryBot.define do
  factory :item do
    product_name          { 'デニム' }
    product_description   { 'とてもよい商品' }
    category_id           { 1 }
    product_condition_id  { 1 }
    delivery_charge_id    { 1 }
    prefecture_id         { 1 }
    shipping_day_id       { 1 }
    price                 { 111_111 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
