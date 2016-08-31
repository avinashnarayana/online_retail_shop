class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :barcode, :null => false
      t.string :name, :null => false, :default => "Unnamed Location"
      t.text :address

      t.timestamps
    end
  end
end
