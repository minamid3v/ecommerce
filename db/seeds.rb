10.times do |i|
  User.create!(user_name:"user_#{i}", email: Faker::Internet.email,
  password: "123456", password_confirmation: "123456", is_admin: false,
  profile_image: open("public/uploads/user/profile_image/24/photo-1453365607868-7deed8cc7d26.jpg"))
end

User.create!(user_name:"admin", email: "admin@framgia.com",
  password: "123456", password_confirmation: "123456", is_admin: true,
  profile_image: open("public/uploads/user/profile_image/24/photo-1453365607868-7deed8cc7d26.jpg"))

Category.create!(name: "Electronics",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Women's Fashion",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Men's Fashion",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Home & Living",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Health & Beauty",
  description: Faker::Lorem.sentence(3, false, 4))
Category.create!(name: "Baby & Toys",
  description: Faker::Lorem.sentence(3, false, 4))

SubCategory.create!(name: "Mobiles & Tablets", category: Category.find(1),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Computers & Laptops", category: Category.find(1),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Cameras", category: Category.find(1),
  description: Faker::Lorem.sentence(5,false,4))

SubCategory.create!(name: "Skirts", category: Category.find(2),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Pants", category: Category.find(2),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Shorts", category: Category.find(2),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Swimwear", category: Category.find(2),
  description: Faker::Lorem.sentence(5,false,4))

SubCategory.create!(name: "Life Skills Toys", category: Category.find(6),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Tunnels", category: Category.find(6),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: "Outdoor Play", category: Category.find(6),
  description: Faker::Lorem.sentence(5,false,4))
SubCategory.create!(name: " Ironing Boards", category: Category.find(6),
  description: Faker::Lorem.sentence(5,false,4))

Classification.create(name: "Normal",
  description: Faker::Lorem.sentence(3, false, 4))
Classification.create(name: "Loyal",
  description: Faker::Lorem.sentence(3, false, 4))
Classification.create(name: "Medium",
  description: Faker::Lorem.sentence(3, false, 4))
Classification.create(name: "Expensive",
  description: Faker::Lorem.sentence(3, false, 4))
Classification.create(name: "Cheap",
  description: Faker::Lorem.sentence(3, false, 4))


OrderStatus.create!(name: "Pending",
  description: Faker::Lorem.sentence(3, false, 4))
OrderStatus.create!(name: "Confirmed",
  description: Faker::Lorem.sentence(3, false, 4))
OrderStatus.create!(name: "Shipping",
  description: Faker::Lorem.sentence(3, false, 4))

Product.create!(name: Faker::Commerce.product_name, description: Faker::Lorem.sentence(5, false, 6), sub_category: SubCategory.find(1), classification: Classification.find(1), price: 100000,
  image: open("public/uploads/user/profile_image/24/photo-1453365607868-7deed8cc7d26.jpg"),
  quantity: 10)
