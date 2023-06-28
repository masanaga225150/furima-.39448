class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  # arthenticate_user!は、Deviseが提供するメソッドで、ログイン状態のチェックを行います。
  # ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させる。
  # before_actionで呼び出すことで、アクションを実行する前にログインしていなければログイン画面に遷移させられる。

 def index
  @items = Item.all # 複数データになるので、@itemsにする
                    # 商品の一覧を取得する
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

 # def edit
  # @item = Item.find(params[:id])
 # end

 private
 def item_params
  params.require(:item).permit(:image,:product_name, :description, :category_id, :condition_id, :shipping_fee_id, :delivery_prefecture_id, :shipping_duration_id, :price).merge(user_id: current_user.id) # item_paramsというストロングパラメーターを定義し、createメソッドの引数に使用して、itemsテーブルへ保存できるようにした。
          # 画像の保存を許可するストロングパラメーター
 end

end
