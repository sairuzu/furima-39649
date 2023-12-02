class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_item, only: %i[show edit update destroy]
  before_action :contributor_confirmation, only: %i[edit update destroy]

  def index
    # @items = Item.includes(:user)
    @items = Item.order(created_at: :desc)
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

  def show
    @user = @item.user
  end

  def edit
    if Order.item_purchased?(@item) || (current_user && current_user.id != @item.user_id)
      redirect_to root_path
      return
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :product_description, :category_id, :product_condition_id,
                                 :delivery_charge_id, :prefecture_id, :shipping_day_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless @item && current_user == @item.user
  end
end
