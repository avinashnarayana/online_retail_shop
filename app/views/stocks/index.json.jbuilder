json.array!(@stocks) do |stock|
  json.extract! stock, :id, :quantity, :location_id, :product_id, :details
  json.url stock_url(stock, format: :json)
end
