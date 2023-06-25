class ItemsController < ApplicationController

 def index
  @items = Item.all
 end

 def new
  @item = Item.new
 end

 def create               # createアクションを定義
  @item = Item.new(item_params)
  if @item.save
    redirect_to root_path
  else
    render :new
  end
 end

 private
 def item_params
  params.require(:item).permit(:name, :image, :text).merge(user_id: current_user.id) # item_paramsというストロングパラメーターを定義し、createメソッドの引数に使用して、itemsテーブルへ保存できるようにした。
 end

end
