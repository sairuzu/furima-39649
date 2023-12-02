class OrderShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number,
                :item_id, :user_id, :token
  
  validates :post_code, presence: true,
                        format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  
  validates :prefecture_id, presence: true, exclusion: { in: ['---'] }
  
  validates :municipalities, :street_address, presence: true

  with_options presence: true, format: { with: /\A[0-9]+\z/, message:  'is invalid. Please enter numbers only' }, length: { in: 10..11 } do
    validates :telephone_number
  end

  with_options presence: true  do
   validates :user_id
   validates :item_id
   validates :token
  end

  def save
    # binding.pry
     order = Order.create(item_id: item_id, user_id: user_id)
     Shipping.create(
      post_code: post_code, 
      prefecture_id: prefecture_id, 
      municipalities: municipalities,
      street_address: street_address, 
      building_name: building_name, 
      telephone_number: telephone_number, 
      order_id: order.id
     )
  end

end
