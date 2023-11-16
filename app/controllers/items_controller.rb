class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  before_action :authenticate_user!, except: :index

  def index
    # @items = Item.includes(:user)
  end

  def new
    @item = Item.new
    @categories = Category.all
    @product_conditions = ProductCondition.all
    @delivery_charges = DeliveryCharge.all
    @prefectures = Prefecture.all
    @shipping_days = ShippingDay.all
  end

  def create
    @item = Item.new(item_params)
    
   if @item.save
     redirect_to root_path
   else
     render :new, status: :unprocessable_entity
   end
 end
  
  
  private

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :product_condition_id, :delivery_charge_id, :prefecture_id, :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end
end
