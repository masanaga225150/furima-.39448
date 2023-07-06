class Order < ApplicationRecord
 
  belongs_to :user
  has_one :item_order, dependent: :destroy
  belongs_to :item

 
end
