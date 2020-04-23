class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).where(status: 1).order('id DESC').limit(3)
  end
end
