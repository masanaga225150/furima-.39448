# テーブル設計

## users テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| nickname             | string     | null: false                    |
| email                | string     | null: false, unique: true      |
| encrypted_password   | string     | null: false                    |
| first_name           | string     | null: false                    |
| last_name            | string     | null: false                    |
| first_name_kana      | string     | null: false                    |
| last_name_kana       | string     | null: false                    |
| birthday             | date       | null: false                    |

### Association

- has_many :items
- has_many :orders  
     
## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| product_name           | string     | null: false                    |
| description            | text       | null: false                    |
| category_id            | integer    | null: false                    |
| condition_id           | integer    | null: false                    |
| shipping_fee_id        | integer    | null: false                    |
| delivery_prefecture_id | integer    | null: false                    |
| shipping_duration_id   | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true | 
                                                                          
### Association  
  
- belongs_to :user  
- has_one :order
     
## items_orders テーブ  ル 
     
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| delivery_zipcode       | string     | null: false                    |
| delivery_prefecture_id | integer    | null: false                    |
| delivery_city          | string     | null: false                    |
| delivery_address       | string     | null: false                    |
| delivery_building      | string     |                                |
| delivery_phone         | string     | null: false                    |
| order                  | integer    | null: false                    |
     
### Association  
  
- belongs_to :order
  
## orders テーブル     
     
| Column                 | Type       | Options                        |
| ---------------------- | ---------- | -------------------------------|
| user                   | references | null: false, foreign_key: true |
| item                   | references | null: false, foreign_key: true |
  
### Association  
  
- belongs_to :user  
- has_one :items_order
- belongs_to :item
  