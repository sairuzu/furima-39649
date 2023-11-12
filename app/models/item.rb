class Item < ApplicationRecord
  belongs_to :user
  has_many :comments
  belongs_to :category
  belongs_to :product_condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day
  has_one :purchase
  has_one_attached :image
end
