class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  
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
  
  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :delivery_charge, :delivery_prefecture, :delivery_dates, :price, :status, :condition, images_attributes: [:image, :_destroy, :id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
