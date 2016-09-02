class Product < ApplicationRecord
  has_many :stocks
  has_many :transfers
  has_many :locations, through: :stocks
  
  default_scope -> { order(updated_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :name, presence: true
  validates :price, presence: true
  validate  :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
