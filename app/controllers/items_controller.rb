class ItemsController < ApplicationController

  def index
    # @articles = Article.includes(:user)
  end

  def new
  
  end
  
  private

  def item_params
    params.require(:item).permit(:content, :image).merge(user_id: current_user.id)
  end
end
