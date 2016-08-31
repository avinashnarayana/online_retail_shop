class AddBarcodeToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :barcode, :string
    add_index :products, :barcode
  end
end
