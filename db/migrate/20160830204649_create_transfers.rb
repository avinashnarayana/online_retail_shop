class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :user, foreign_key: true
      t.references :from_location, foreign_key: true
      t.references :to_location, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.text :details

      t.timestamps
    end
  end
end
