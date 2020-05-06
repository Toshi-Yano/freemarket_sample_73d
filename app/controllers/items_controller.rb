class ItemsController < ApplicationController
  before_action :set_item, only:[:show, :destroy, :edit, :update, :purchase, :payment]
  before_action :set_item, except: [:new, :index, :create]
  before_action :move_to_index, except: [:index, :show]
  before_action :move_to_index_unless_owner, only: [:edit, :update, :destroy]
  require "payjp"
  
  def index
    @items = Item.includes(:images).where(status: 1).order('id DESC').limit(3)
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent_array = Category.where(ancestry: nil)
  end
  


  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @images = @item.images
    @top_image = @images.first
    @parents = Category.all
  end

  def edit
  end

  def update
    if @item.update(update_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :edit
    end
  end

  def purchase
    card = Creditcard.find_by(user_id: current_user.id)
    if card.present? && @item.status === 1
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.data[0]
    else
      # redirect_to root_path
      # 後でエラーハンドリング
    end
  end

  def pay
    

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :delivery_charge_id, :prefecture_id, :delivery_dates_id, :price, :status, :condition_id, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:item).permit(:name, :user_id, :description, :category_id, :delivery_charge_id, :prefecture_id, :delivery_dates_id, :price, :status, :condition_id, images_attributes: [:image, :_destroy, :id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def move_to_index_unless_owner
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user_id
  end
  
end
