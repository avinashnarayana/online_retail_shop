class Stock < ApplicationRecord
  belongs_to :location
  belongs_to :product
  validates_numericality_of :quantity, :greater_than_or_equal_to => 0
  before_save :default_values
  def default_values
    self.quantity ||= 0
  end
end
