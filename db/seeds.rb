# --- Users ----
User.create!(first_name: "Test",
             last_name:  "Admin",
             email: "test.admin@example.co.uk",
             password:              "foobarfoo",
             password_confirmation: "foobarfoo",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

 User.create!(first_name: "Test",
              last_name:  "Customer",
              email: "test.customer@example.co.uk",
              password:              "foobarfoo",
              password_confirmation: "foobarfoo",
              activated: true,
              activated_at: Time.zone.now)

97.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "example-#{n+1}@example.co.uk"
  password = "password"
  User.create!(first_name: first_name,
               last_name:  last_name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# ----- PRODUCTS -----

# Categories
categories = %w[cards bath\ bombs soaps wax\ melts]
categories.each do |cat_name|
  Category.create!(name: cat_name)
end

# sub-categories for cards
category = Category.find(1)
sub_categories = %w[birthday valentines wedding mothers\ day fathers\ day]
sub_categories.each do |sub_cat|
  category.sub_categories.create!(name: sub_cat)
end

# Add cards
test_img_path = File.open(File.join(Rails.root, '/app/assets/images/test_card.jpg'))
sub_cats = SubCategory.where(category: category)
sub_cats.each do |sub_cat|
  10.times do |n|
    category.products.create!(sub_category: sub_cat,
                              name: "#{sub_cat.name.capitalize} Card #{n + 1}",
                              description: Faker::Lorem.sentence(rand(20..60)),
                              price: rand(1..3.5).round(2),
                              quantity: rand(5..20),
                              primary_img: test_img_path)
  end
end

# Sub-categories for bath bombs
category = Category.find(2)
sub_categories = %w[fruity floral sweet]
sub_categories.each do |sub_cat|
  category.sub_categories.create!(name: sub_cat)
end

# Add bath bombs
test_img_path = File.open(File.join(Rails.root, '/app/assets/images/test_bath_bomb.jpeg'))
sub_cats = SubCategory.where(category: category)
sub_cats.each do |sub_cat|
  10.times do |n|
    category.products.create!(sub_category: sub_cat,
                              name: "#{sub_cat.name.capitalize} Bath Bomb #{n + 1}",
                              description: Faker::Lorem.sentence(rand(20..60)),
                              price: rand(1..3.5).round(2),
                              quantity: rand(5..20),
                              primary_img: test_img_path)
  end
end

# --- Shopping Bags ---

3.times do |n|
  ShoppingBag.create(user_id: n + 1)
end

# ---- Adresses ----

Address.create!(user: User.first, line_1: "45 Barrymore Walk", town: "Rayleigh",
                county: "Essex", postcode: "ss6 8yf")

Address.create!(user: User.first, line_1: "10 Barrymore Walk", town: "Rayleigh",
                county: "Essex", postcode: "ss6 8yf")

# --- Orders ---

def add_order_items(order)
  item_total = 0
  rand(1..5).times do
    item = order.order_items.create!(product_id: rand(1..Product.count), quantity: rand(1..4))
    item_total += item.product.price * item.quantity
  end
  order.update(item_total: item_total, postage: 2.95)
end

2.times do |n|
  order = Order.create!(user: User.first, status: 1,
                        shipping_address_id: 1, billing_address_id: 1)
  add_order_items(order)
end

3.times do |n|
  order = Order.create!(user: User.first, status: 3,
                        shipping_address_id: 2, billing_address_id: 2,
                        created_at: Time.zone.yesterday)
  add_order_items(order)
end

30.times do |n|
  order = Order.create!(user: User.last, status: 3,
                        shipping_address_id: 1, billing_address_id: 1,
                        created_at: 3.days.ago,)
  add_order_items(order)
end
