class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.references :user, foreign_key: true
      t.references :from_location, references: :locations
      t.references :to_location, references: :locations
      t.references :product, foreign_key: true
      t.integer :quantity
      t.text :details

      t.timestamps
      add_foreign_key :transfers, :locations, column: :from_location
      add_foreign_key :transfers, :locations, column: :to_location
    end
  end
end
