User.create!(name:  "Avinash N Regulagadda",
             email: "avinash.narayana@gmail.com",
             password:              "password",
             password_confirmation: "password",
             role: 1)   # 1 for store keeper/admin
             
User.create!(name:  "Example User",
             email: "example@example.org",
             password:              "foobar",
             password_confirmation: "foobar",
             role: 1)   # 1 for store keeper/admin

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end