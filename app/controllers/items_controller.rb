class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy, :purchase, :pay]

  require "payjp"

  def index
  end

  def new
    @item = Item.new
    @item.images.new
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
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
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
    if card.present? && @item.status === 1 # status[1] = 購入可能
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.data[0]
    else
      redirect_to root_path
      flash[:alert] = "購入処理が失敗しました"
    end
  end

  def pay
    card = Creditcard.find_by(user_id: current_user.id)
    if card.present? && @item.status === 1 # status[1] = 購入可能
      @item.status = 2 # 購入済に変更
      @item.save!
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      @charge = Payjp::Charge.create(
        amount: @item.price,
        customer: card.customer_id,
        currency: "jpy"
      )
    else
      redirect_to item_path(@item)
      flash[:alert] = "支払い処理が失敗しました"
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :delivery_charge_id, :prefecture_id, :delivery_dates_id, :price, :status, :condition_id, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end
  
end
