# テーブル設計

## users テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| nick_name            | string     | null: false                    |   # null: false: カラムが空の状態では保存できない
| email                | string     | null: false, unique: true      |   # unique: true 一意性のみ許可(同じ値は保存できない)
| encrypted_password   | string     | null: false                    |   # encrypted_password ユーザー登録時などに入力するパスワードの意味
| first_name           | string     | null: false                    |   # encryptedは「暗号化された」という意味
| last_name            | string     | null: false                    |
| first_name_kana      | string     | null: false                    |
| last_name_kana       | string     | null: false                    |
| birthday             | date       | null: false                    |

### Association

- has_many :items
- has_many :orders  
     
## items テーブル                                                     # 画像に関するカラムを用意する必要がない。「active_storage」のgemを使用することで、テーブルなどが自動生成されるためです。 
                                    # ActiveHashとは、都道府県などの変更されないデータをモデルファイル内に直接記述することで、データベースへ保存せずにデータを取り扱うことができるGemです。
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| seller_name            | string     | null: false                    |
| description            | text       | null: false                    |
| category_id            | integer    | null: false                    | # Active Hashを利用する場合は、各種情報に対応するモデルを作成する。categoryモデル
| condition_id           | integer    | null: false                    | # conditionモデル
| shipping_fee_id        | integer    | null: false                    | # shipping_feeモデル
| delivery_prefecture_id | integer    | null: false                    | # 都道府県
| shipping_duration_id   | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |  # references 他テーブルから情報を参照する際に用いる型です。userと記載するとuser_idというカラムが生成されます。 
                                                                          # foreign_key: true 外部キーを設定(別テーブルのカラムを参照する)
### Association  
  
- belongs_to :user  
- has_one :order                # 親: itemモデル
     
## items_orders テーブ  ル 
     
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| delivery_zipcode       | string     | null: false                    |
| delivery_prefecture    | string     | null: false                    |  # 都道府県
| delivery_city          | string     | null: false                    |
| delivery_address       | string     | null: false                    |
| delivery_buildeng      | string     |                                |  # 建物名は入力任意項目のためNOT NULL制約はかけない
| delivery_phone         | string     | null: false                    |
| order                  | integer    | null: false                    |  
     
### Association  
  
- belongs_to :order          # 子
  
## orders テーブル     
     
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| user                   | references | null: false, foreign_key: true |
| item                   | references | null: false, foreign_key: true |
  
### Association  
  
- belongs_to :user  
- has_one :items_order       # 親
- belongs_to :item           # 子: orderモデル
  
  
    
    
  
| カラムの型             | 説明       | 用途                                  |      
| -------------------  | ---------- | -------------------------------------|           
| integer              | 数値        | 金額、回数など                         |      
| string               | 文字(短文)  | ユーザー名、メールアドレスなど            |
| text                 | 文字(長文)  | 投稿文、説明文など                      |
| boolean              | 真か偽か    | はい・いいえの選択、合格・不合格のフラグなど |
| datetime             | 日付と時刻   | 作成日時、更新日時など                  | 
| bytea                | image      | imageカラムの型 PostgreSQLで使用できる   |