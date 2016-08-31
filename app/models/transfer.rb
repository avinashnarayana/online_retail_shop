class Transfer < ApplicationRecord
  belongs_to :user
  belongs_to :from_location, class_name: "Location"
  belongs_to :to_location, class_name: "Location"
  belongs_to :product
end
