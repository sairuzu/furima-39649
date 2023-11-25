class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @items = Item.all
  end

  def new
    @order_shipping = OrderShipping.new
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
      @order_shipping.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping).permit(:post_code, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end
end
