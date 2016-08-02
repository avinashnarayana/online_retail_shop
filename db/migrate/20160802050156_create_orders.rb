class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :delivery_name
      t.text :delivery_address
      t.text :order_updates
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
