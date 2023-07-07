class Order < ApplicationRecord
  belongs_to :user
  has_one :item_order
  belongs_to :item
end
