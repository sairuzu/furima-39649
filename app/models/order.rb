class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :shipping
  def self.item_purchased?(item)
    where(item_id: item.id).exists?
  end
end
