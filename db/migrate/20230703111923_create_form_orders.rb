class CreateFormOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :form_orders do |t|

      t.timestamps
    end
  end
end
