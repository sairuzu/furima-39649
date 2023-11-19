module ApplicationHelper
  def delivery_charge_name(item)
    delivery_charge = DeliveryCharge.find_by(id: item.delivery_charge_id)
    delivery_charge&.name || '未設定' 
  end
end
