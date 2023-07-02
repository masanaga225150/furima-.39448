class ItemsOrder < ApplicationRecord

  belongs_to :order

  validates :delivery_zipcode, presence: true
  validates :delivery_prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_city, presence: true
  validates :delivery_address, presence: true
  validates :delivery_building, presence: true
  validates :delivery_phone, presence: true

end
