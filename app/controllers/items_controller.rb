class ItemsController < ApplicationController
  before_action :set_item, except: [:new,:index, :create]

  
  def index
  end

  def new
    @item = Item.new
    @item.images.new
    # @category_parent_array = ["---"]
    #   Category.where(ancestry: nil).each do |parent|
    #     @category_parent_array << parent.name
    #   end
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
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def
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
