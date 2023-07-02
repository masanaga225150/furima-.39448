class Order < ApplicationRecord

  belongs_to :user
  has_one :items_order
  belongs_to :item
  
  validates :price, presence: true
end
