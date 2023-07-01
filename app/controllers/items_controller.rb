class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :redirect_to_root_if_not_owner, only: [:edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  # arthenticate_user!は、Deviseが提供するメソッドで、ログイン状態のチェックを行います。
  # ユーザーがログインしていなければ、そのユーザーをログイン画面に遷移させる。
  # before_actionで呼び出すことで、アクションを実行する前にログインしていなければログイン画面に遷移させられる。

  def index
    @items = Item.all.order(created_at: :desc) # 複数データになるので、@itemsにする
    # 商品の一覧を取得する
  end

  def new
    @item = Item.new # newメソッド Itemクラスの新しいインスタンスを作成
  end

  def create # createアクションを定義
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
    @items = Item.all
  end

  def update
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit
    end
  end

  def redirect_to_root_if_not_owner
    item = Item.find(params[:id])
    return unless current_user != item.user
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :product_name, :description, :category_id, :condition_id, :shipping_fee_id, :delivery_prefecture_id, :shipping_duration_id, :price).merge(user_id: current_user.id) # item_paramsというストロングパラメーターを定義し、createメソッドの引数に使用して、itemsテーブルへ保存できるようにした。
    # 画像の保存を許可するストロングパラメーター
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
