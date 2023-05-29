require 'faker'

#create snack products
Item.destroy_all
20.times do 
  Item.create(
    name: Faker::Food.unique.fruits,
    price: rand(10.00..50.00),
    stock: rand(20..50)
  )
end

# User
User.destroy_all
admin = User.new(email: "admin@snackstore.com", password: "123456", first_name: "kevin", last_name: "kevin")
admin.admin = true
admin.support = true
admin.save

support = User.new(email: "support@snackstore.com", password: "123456", first_name: "sup", last_name: "port")
support.support = true
support.save

customer = User.new(email: "michi@snackstore.com", password: "123456", first_name: "mich", last_name: "hi")
customer.save