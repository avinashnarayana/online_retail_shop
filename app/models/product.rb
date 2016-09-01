class Product < ApplicationRecord
  has_many :stocks
  has_many :transfers
  has_many :locations, through: :stocks
  
  default_scope -> { order(updated_at: :desc) }
  validates :name, presence: true
  validates :price, presence: true
end
