json.array!(@transfers) do |transfer|
  json.extract! transfer, :id, :user_id, :from_location_id, :to_location_id, :product_id, :quantity, :details
  json.url transfer_url(transfer, format: :json)
end
