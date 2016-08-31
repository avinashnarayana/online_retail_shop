class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.references :location, foreign_key: true
      t.references :product, foreign_key: true
      t.text :details

      t.timestamps
    end
  end
end
