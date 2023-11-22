class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

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
  end
  
  def update
    if @item.update(item_params)
      redirect_to item_path(@item) 
    else
      render :edit, status: :unprocessable_entity
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
