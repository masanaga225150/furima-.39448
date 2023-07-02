class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end
  
  def create
    @order = Order.new(item_id: params[:item_id])
  end

end
