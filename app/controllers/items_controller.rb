class ItemsController < ApplicationController
  def index
    @ladies = Item.includes(:images).where('status = ? and category_id = ?', 1, 1).order('id DESC').limit(3)
    @mens = Item.includes(:images).where('status = ? and category_id = ?', 1, 200).order('id DESC').limit(3)
    @electricals = Item.includes(:images).where('status = ? and category_id = ?', 1, 872).order('id DESC').limit(3)
    @toys = Item.includes(:images).where('status = ? and category_id = ?', 1, 620).order('id DESC').limit(3)
  end
end