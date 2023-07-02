class CreateItemsOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :items_orders do |t|
      t.string       :delivery_zipcode,           null: false
      t.integer      :delivery_prefecture_id,     null: false
      t.string       :delivery_city,              null: false
      t.string       :delivery_address,           null: false
      t.string       :delivery_building,          null: false
      t.string       :delivery_phone,             null: false
      t.integer      :order,                      null: false
      t.timestamps
    end
  end
end
