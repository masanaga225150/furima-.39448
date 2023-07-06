class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]

  def index
     @item = Item.find(params[:item_id])
    if current_user == @item.user || @item.order.present?
       redirect_to root_path
    else
     @form_order = FormOrder.new
    end
  end
  
  def create
    @form_order = FormOrder.new(item_order_params)
    @item = Item.find(params[:item_id])
    if @form_order.valid?
      pay_item
      @form_order.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_order_params
    params.require(:form_order).permit(:delivery_zipcode, :delivery_prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone).merge( user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: item_order_params[:token],
      currency: 'jpy'
    )
  end

end
