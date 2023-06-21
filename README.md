# テーブル設計

## users テーブル

| Column               | Type       | Options                        |
| -------------------  | ---------- | ------------------------------ |
| nick_name            | string     | null: false                    |   # null: false: カラムが空の状態では保存できない
| email                | string     | null: false                    |   
| encrypted_password   | string     | null: false                    |   # encrypted_password ユーザー登録時などに入力するパスワードの意味
| name                 | string     | null: false                    |   # encryptedは「暗号化された」という意味
| name_kana            | string     | null: false                    |
| birthday             | datetime   | null: false                    |

### Association

- has_many :items
- has_many :orders
- has_many :comments
   
## items テーブル   
   
| Column               | Type       | Options                        |
| -------------------  | ---------- | -------------------------------|
| seller_name          | string     | null: false                    |
| image                | bytea      | null: false                    |
| title                | string     | null: false                    |
| description          | text       | null: false                    |
| category             | string     | null: false                    |
| condition            | string     | null: false                    |
| shipping_fee         | string     | null: false                    |
| origin_area          | string     | null: false                    |
| shipping_duration    | string     | null: false                    |
| price                | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |  # references 他テーブルから情報を参照する際に用いる型です。userと記載するとuser_idというカラムが生成されます。 
  
### Association

- belongs_to :user
- has_many :items_orders
- has_one :order
   
## items_orders テー  ブル 
   
| Column               | Type       | Options                        |
| -------------------  | ---------- | -------------------------------|
| delivery_zipcode     | string     | null: false                    |
| delivery_prefecture  | string     | null: false                    |
| delivery_dity        | string     | null: false                    |
| delivery_address     | string     | null: false                    |
| delivery_buildeng    | string     | null: false                    |
| delivery_phone       | string     | null: false                    |
| item                 | references | null: false, foreign_key: true |  # foreign_key: true 外部キーを設定(別テーブルのカラムを参照する)
| order                | references | null: false, foreign_key: true |  # unique: true 一意生のみ許可(同じ値は保存できない)
   
### Association

- belongs_to :item
- belongs_to :order

## orders テーブル   
   
| Column               | Type       | Options                        |
| -------------------  | ---------- | -------------------------------|
| seller_name          | string     | null: false                    |
| buyer_name           | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :items_orders
- has_one :item

## comments テーブル

| Column               | Type       | Options                        |
| -------------------  | ---------- | -------------------------------|
| seller_name          | string     | null: false                    |
| buyer_name           | string     | null: false                    |
| text                 | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |  
| order                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- bilongs_to :order
  
  
  
  
| カラムの型             | 説明       | 用途                                  |      
| -------------------  | ---------- | -------------------------------------|           
| integer              | 数値        | 金額、回数など                         |      
| string               | 文字(短文)  | ユーザー名、メールアドレスなど            |
| text                 | 文字(長文)  | 投稿文、説明文など                      |
| boolean              | 真か偽か    | はい・いいえの選択、合格・不合格のフラグなど |
| datetime             | 日付と時刻   | 作成日時、更新日時など                  | 
| bytea                | image      | imageカラムの型 PostgreSQLで使用できる   |