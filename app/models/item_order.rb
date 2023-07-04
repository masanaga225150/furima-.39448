class ItemOrder < ApplicationRecord
  
  belongs_to :order

  validates :delivery_zipcode, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: "Postal code is invalid.Enter it as follows (e.g. 123-4567)" }
  validates :delivery_prefecture_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :delivery_city, presence: true
  validates :delivery_address, presence: true
  validates :delivery_phone, presence: true, length: { in: 10..11, too_short: "Phone number is too short" }, format: { with: /\A\d+\z/, message: "Phone number is invalid. Input only number" }

end
