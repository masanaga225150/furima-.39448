class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_to_root_if_not_owner, only: [:edit, :update]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if current_user == item.user
     item.destroy
     redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def redirect_to_root_if_not_owner
    item = Item.find(params[:id])
    return unless current_user != item.user
    redirect_to root_path
  end

  def item_params
    params.require(:item).permit(:image, :product_name, :description, :category_id, :condition_id, :shipping_fee_id,
                                 :delivery_prefecture_id, :shipping_duration_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
