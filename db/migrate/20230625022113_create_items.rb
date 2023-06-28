class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t| # 「itemsテーブルを作成する」という仕様がマイグレーションファイルに記載されている。
      t.string     :product_name,             null: false
      t.text       :description,             null: false
      t.integer    :category_id,             null: false
      t.integer    :condition_id,            null: false
      t.integer    :shipping_fee_id,         null: false
      t.integer    :delivery_prefecture_id,  null: false
      t.integer    :shipping_duration_id,    null: false
      t.integer    :price,                   null: false
      t.references :user,                    null: false, foreign_key: true
      t.timestamps
    end
  end
end

# マイグレーションは、テーブルの設計図・仕様書です。
# 記入したらマイグレーションを実行 rails db:migrate マイグレーションファイルの情報をテーブルに反映する
# マイグレーションファイルがdownの時はマイグレーションファイルの修正が可能
# 編集する時は、rails db:rollbackで差し戻してからする。
# 商品(item)を表示するときに「変更されないデータ(categoryやcondition)」を紐付けて取得するため、末尾に「_id」をつけたカラム名で保存する。
# データ項目名をidで管理する。idは数値になるのでinteger型を指定。