class FormOrder 
  include ActiveModel::Model
  attr_accessor :card_number, :card_exp_month, :card_exp_year, :card_cvc, :delivery_zipcode, :delivery_prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone, :order_id

  validates :card_number, presence: true
  validates :card_exp_month, presence: true
  validates :card_exp_year, presence: true
  validates :card_cvc, presence: true

  def save
    Order.create(user_id: user_id, item_id: item_id)
    ItemOrder.create(delivery_zipcode: delivery_zipcode, delivery_prefecture_id: delivery_prefecture_id, delivery_city: delivery_city, delivery_address: delivery_address, delivery_building: delivery_building, delivery_phone: delivery_phone, order_id: order_id)
  end

  attr_accessor :token
  validates :price, presence: true
  validates :token, presence: true
end
