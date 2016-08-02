class Product < ApplicationRecord
  default_scope -> { order(updated_at: :desc) }
  validates :name, presence: true
  validates :price, presence: true
  validates :stock, presence: true
end
