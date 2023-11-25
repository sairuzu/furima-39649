class OrderShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number,
                :order_id, :item_id, :user_id

  validates :post_code, presence: true,
                        format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :prefecture_id, presence: true, exclusion: { in: ['---'] }
  validates :municipalities, presence: true
  validates :street_address, presence: true
  with_options presence: true, format: { with: /\A[0-9]+\z/, message: '半角数値のみを使用してください' }, length: { in: 10..11 } do
    validates :telephone_number

    def save
      order = Order.create(item: item_id, user_id:)
      Shipping.create(post_code:, prefecture_id:, municipalities:,
                      street_address:, building_name:, telephone_number:, order_id:)
    end
  end
end
