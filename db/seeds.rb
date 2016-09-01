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

User.create!(name:  "Customer",
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

Product.create(id: 1, name: "Amber Leaf",
            description: "Tobacco 25g pack", 
            price: 12.0, barcode: "5011054355409")
Product.create(id: 2, name: "Germentin", 
            description: "A medicine", price: 516.0, barcode: "509915101122")

            