json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :order_id, :product_id, :quantity
  json.url transaction_url(transaction, format: :json)
end
