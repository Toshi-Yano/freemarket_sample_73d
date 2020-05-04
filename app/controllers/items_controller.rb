class ItemsController < ApplicationController
  before_action :set_item, except: [:new, :index, :create]
  before_action :move_to_index, except: [:index, :show]
  before_action :move_to_index_unless_owner, only: [:edit, :update, :destroy]
  
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
      render :new, alert: "入力されていない項目があります"
    end
  end

  def show
    @images = @item.images
    @top_image = @images.first
  end

  def edit
  end

  def update
    if @item.update(update_params)
      # redirect_to item_path(@item.id)
    else
      # flash.now[:alert] = @item.errors.full_messages
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

  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
  #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def move_to_index_unless_owner
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user_id
  end
  
end
