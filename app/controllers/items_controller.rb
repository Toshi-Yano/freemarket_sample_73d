class ItemsController < ApplicationController
  before_action :set_item, only:[:show, :destroy, :edit, :update, :purchase, :pay]
  before_action :move_to_index, except: [:index, :show]
  before_action :move_to_index_unless_owner, only: [:edit, :update, :destroy]
  before_action :set_card_and_key, only: [:purchase, :pay]

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
    @items = Item.find(params[:id])
    @category_parent_array = Category.where(ancestry:nil)
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
    if user_can_purchase_item?
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.data[0]
    else
      redirect_to root_path
      flash[:alert] = "購入処理が失敗しました"
    end
  end

  def pay
    if user_can_purchase_item?
      @item.status = 2 # 購入済に変更
      @item.save!
      @charge = Payjp::Charge.create(
        amount: @item.price,
        customer: @card.customer_id,
        currency: "jpy"
      )
    else
      redirect_to item_path(@item)
      flash[:alert] = "支払い処理が失敗しました"
    end
  end

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

  def set_card_and_key
    @card = Creditcard.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
  end

  def user_can_purchase_item?
    @card.present? && @item.status === 1 # status[1] = 購入可能
  end
  
end
