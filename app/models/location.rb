class Location < ApplicationRecord
    #before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 100 }, uniqueness:true
    VALID_BARCODE_REGEX = /\A\d+\z/
    validates :barcode, presence: true, length: { maximum: 30 },
                    format: { with: VALID_BARCODE_REGEX },
                    uniqueness: true
end
