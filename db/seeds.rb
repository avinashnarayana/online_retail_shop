User.create!(name:  "Store Keeper",
             email: "storekeeper@storekeeper.com",
             password:              "password",
             password_confirmation: "password",
             role: 1)   # 1 for store keeper/admin
             
User.create!(name:  "Store Assistant",
             email: "storeassistant@storeassistant.com",
             password:              "password",
             password_confirmation: "password",
             role: 2)   # 2 for store assistant

User.create!(name:  "Guest Customer",
             email: "customer@customer.com",
             password:              "password",
             password_confirmation: "password",
             role: 0)   # 0 for customer

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end


product = Product.create(name: "PS Nail Polish Remover", description: "70ml bottle", price: 4.99, barcode: "2911038", picture: "20160902_020940.jpg")

Product.create(name: "Gold Amber", description: "50ml bottle", price: 29.0, barcode: "384733017", picture: "20160902_021018.jpg")

Product.create(name: "Perspirex - Original", description: "Antiperspirant Roll-on", price: 9.99, picture: "20160902_021029.jpg", barcode: "5701943011409")

Product.create(name: "Germentin", 
            description: "A medicine", price: 516.0, barcode: "509915101122")


Product.create(name: "Amber Leaf",
            description: "Tobacco 25g pack", 
            price: 12.0, barcode: "5011054355409")
            
99.times do |n|
    Product.create(name: Faker::Commerce.product_name, description: "Test Product", price: Faker::Commerce.price, barcode: (1000000+n).to_s)
end
    
Location.create(barcode: "34567", name: "Suppliers")

online_stock = Location.create(barcode: "12345", name: "Online Sales Stock")

shop_stock = Location.create(barcode: "23456", name: "Shop Floor")

Product.all.each do |p|
    p.stocks.create(quantity: 50, location_id: online_stock.id)
    p.stocks.create(quantity: 50, location_id: shop_stock.id)
end