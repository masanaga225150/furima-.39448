class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @items_order = ItemsOrder.new
  end

  def new
  end
  
  def create
    @items_order = ItemsOrder.new(items_order_params)
    @items_order.item_id = params[:item_id]
    if @items_order.valid?
      @items_order.save
      return redirect_to root_path
    else
      render "index"
    end
  end

  private

  def order_params
    params.require(:items_order).permit(:delivery_zipcode, :delivery_prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone)
  end

end
