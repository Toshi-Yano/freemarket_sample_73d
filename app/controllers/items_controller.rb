class ItemsController < ApplicationController
  before_action :set_item, except: [:new,:index, :create]
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
  
  def index
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new, alert: "入力されていない項目があります"
    end
  end

  def show
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def
    @item.destroy
    redirect_to root_path
  end
  

  #jsonで親の名前で検索し、紐づく小カテゴリーの配列を取得
  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  #jsonで子カテゴリーに紐づく孫カテゴリーの配列を取得
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end


  private
  #親カテゴリー
  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :delivery_charge_id, :prefecture_id, :delivery_dates_id, :price, :status, :condition_id, images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
