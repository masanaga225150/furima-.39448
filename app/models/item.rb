class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # ActiveHashを用いて、belongs_toを設定するには、上記を記述してmoduleを取り込む。
  # ActiveRecordメソッドとは、モデルがテーブル操作に関して使用できるメソッドです。

  belongs_to :user
  # has_one :order
  has_one_attached :image # レコードとファイルの間に1対1のマッピングを設定する。商品一点につき一個の画像を添付する
  # この記述により、モデル.ファイル名(item.image)で、添付されたファイルにアクセスできるようになる。
  # ファイル名がimage。このファイル名は、そのモデルが紐づいたフォームから送られるパラメーターのキーにもなります。
  # Itemテーブルに画像ファイルを紐付けた。

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :delivery_prefecture
  belongs_to :shipping_duration

  # validates :title, :text, presence: true

  # with_options numericality: {other_than: 1, message: "can't be blank"} do
  #   validates :category_id
  #   validates :condition_id
  #   validates :shipping_fee_id
  #   validates :dlivery_prefecture_id
  #   validates :shipping_duration_id
  # end
  validates :image, presence: true
  validates :product_name, presence: true
  validates :description, presence: true
  validates :category_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :condition_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_duration_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  # numericalityとは、数値かどうかを検証するバリデーションの一種、id: 1 以外であれば保存できるように設定する
  # 数値であればデータベースに保存を許可して、それ以外では保存が許可されないようにできる。
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
 
end
