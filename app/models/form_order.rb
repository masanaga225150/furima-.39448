class FormOrder
  include ActiveModel::Model
  attr_accessor :delivery_zipcode, :delivery_prefecture_id, :delivery_city, :delivery_address, :delivery_building,
                :delivery_phone, :item_id, :user_id
  attr_accessor :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :delivery_zipcode,
              format: { with: /\A\d{3}-\d{4}\z/, message: 'Postal code is invalid.Enter it as follows (e.g. 123-4567)' }
    validates :delivery_prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :delivery_city
    validates :delivery_address
    validates :delivery_phone, length: { in: 10..11, too_short: 'Phone number is too short' },
                               format: { with: /\A\d+\z/, message: 'Phone number is invalid. Input only number' }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ItemOrder.create(delivery_zipcode: delivery_zipcode, delivery_prefecture_id: delivery_prefecture_id,
                     delivery_city: delivery_city, delivery_address: delivery_address, delivery_building: delivery_building, delivery_phone: delivery_phone, order_id: order.id)
  end
end
