class ItemsController < ApplicationController
  before_action :set_item, only:[:show, :destroy, :edit, :update, :purchase, :payment]

  
  def index
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
      render :new, alert: "入力されていない項目があります"
    end
  end

  def show
    @item = Item.find(params[:id])
    @images = @item.images
    @top_image = @images.first
    @parents = Category.all
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

  def set_item
    @item = Item.find(params[:id])
  end
  
end
