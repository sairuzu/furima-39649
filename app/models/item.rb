class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :product_condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day

  has_one_attached :image
  # has_many :comments
  has_one :order

  validates :product_name, presence: true
  validates :product_description, presence: true
  validates :category_id, presence: true, exclusion: { in: ['---'] }
  validates :product_condition_id, presence: true, exclusion: { in: ['---'] }
  validates :delivery_charge_id, presence: true, exclusion: { in: ['---'] }
  validates :prefecture_id, presence: true, exclusion: { in: ['---'] }
  validates :shipping_day_id, presence: true, exclusion: { in: ['---'] }

  with_options presence: true, format: { with: /\A[0-9]+\z/, message: '半角数値のみを使用してください' } do
    validates :price
  end
  validates :price, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 300,
                                    less_than_or_equal_to: 9_999_999,
                                    message: 'must be between ¥300 and ¥9,999,999' }

  validates :image, presence: true
  def was_attached?
    image.attached?
  end

  def sold_out?
    sold.present? && sold
  end
  
end

# , numericality: { other_than: 0 }
