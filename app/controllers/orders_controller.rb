class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @item_order = ItemOrder.new
  end

  def new
    @item_order = ItemOrder.new
  end
  
  def create
    @item_order = ItemOrder.new(item_order_params)
    if @item_order.valid?
      pay_item
      @item_order.save
      return redirect_to root_path
    else
      render "index"
    end
  end

  private

  def item_order_params
    params.require(:item_order).permit(:delivery_zipcode, :delivery_prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone).merge(item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: item_order_params[:price],
      card: item_order_params[:token],
      currency: 'jpy'
    )
  end

end
