class FormOrder 
  include ActiveModel::Model
  attr_accessor  :delivery_zipcode, :delivery_prefecture_id, :delivery_city, :delivery_address, :delivery_building, :delivery_phone, :item_id, :user_id
  attr_accessor :token

  validates :token, presence: true

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ItemOrder.create(delivery_zipcode: delivery_zipcode, delivery_prefecture_id: delivery_prefecture_id, delivery_city: delivery_city, delivery_address: delivery_address, delivery_building: delivery_building, delivery_phone: delivery_phone, order_id: order.id)
  end
 
end