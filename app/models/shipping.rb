class Shipping < ApplicationRecord
  # extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :order
  

  # validates :post_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  # validates :prefecture_id, presence: true, exclusion: { in: ['---'], message: "can't be blank" }
  # validates :municipalities, presence: true
  # validates :street_address, presence: true
  # with_options presence: true, format: { with: /\A[0-9]+\z/, message: '半角数値のみを使用してください' }, length: { in: 10..11 } do
  #  validates :telephone_number
end
