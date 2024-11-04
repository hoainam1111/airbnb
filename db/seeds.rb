# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# amenity1 = Amenity.create!(name: "Kitchen")
# amenity1.icon.attach(io: File.open("app/assets/images/amenity_icons/kitchen.svg"), filename: amenity1.name)
# amenity2 = Amenity.create!(name: "Private Pool")
# amenity2.icon.attach(io: File.open("app/assets/images/amenity_icons/private_pool.svg"), filename: amenity2.name)
# amenity3 = Amenity.create!(name: "Wifi")
# amenity3.icon.attach(io: File.open("app/assets/images/amenity_icons/wifi.svg"), filename: amenity3.name)
# amenity4 = Amenity.create!(name: "Essentials", description: "Towels, bed sheets, soap and toilet paper")
# amenity4.icon.attach(io: File.open("app/assets/images/amenity_icons/essentials.svg"), filename: amenity4.name)

amenities_data = [
  { name: 'Air conditioning', icon: "air_conditioning.svg" },
  { name: 'Balcony', icon: "balcony.svg" },
  { name: 'Bed linen', icon: "bed_linen.svg" },
  { name: 'Board games', icon: "board_games.svg" },
  { name: 'Carbon monoxide alarm', icon: "carbon_monoxide_alarm.svg" },
  { name: 'Coffee maker', icon: "coffee_maker.svg" },
  { name: 'Cooker', icon: "cooker.svg" },
  { name: 'Cooking basics', icon: "cooking_basics.svg", description: 'Pots and pans, oil, salt and pepper' },
  { name: 'Cot', icon: "cot.svg" },
  { name: 'Dedicated workspace', icon: "dedicated_workspace.svg" },
  { name: 'Dining table', icon: "dining_table.svg" },
  { name: 'Dishes and cutlery', icon: "dishes_and_cutlery.svg", description: 'Bowls, chopsticks, plates, cups, etc.' },
  { name: 'Dishwasher', icon: "dishwasher.svg" },
  { name: 'Dryer', icon: "dryer.svg" },
  { name: 'Esssentials', icon: "essentials.svg", description: 'Towels, bed sheets, soap and toilet paper' },
  { name: 'Fire extinguisher', icon: "fire_extinguisher.svg" },
  { name: 'First aid kit', icon: "first_aid_kit.svg" },
  { name: 'Free parking', icon: "free_parking.svg" },
  { name: 'fridge', icon: "fridge.svg" },
  { name: 'Garden', icon: "garden.svg", description: 'An open space on the property usually covered in grass' },
  { name: 'Hair dryer', icon: "hair_dryer.svg" },
  { name: 'Hangers', icon: "hangers.svg" },
  { name: 'Heating', icon: "heating.svg" },
  { name: 'Hot tub', icon: "hot_tub.svg" },
  { name: 'Hot water', icon: "hot_water.svg" },
  { name: 'Iron', icon: "iron.svg" },
  { name: 'Kitchen', icon: "kitchen.svg", description: 'Space where guests can cook their own meals' },
  { name: 'Lockbox', icon: "lockbox.svg" },
  { name: 'Microwave', icon: "microwave.svg" },
  { name: 'Mountain view', icon: "mountain_view.svg" },
  { name: 'Oven', icon: "oven.svg" },
  { name: 'Pool table', icon: "pool_table.svg" },
  { name: 'Private entrance', icon: "private_entrance.svg", description: 'Separate street or building entrance' },
  { name: 'Private pool', icon: "private_pool.svg" },
  { name: 'Shampoo', icon: "shampoo.svg" },
  { name: 'Smoke alarm', icon: "smoke_alarm.svg" },
  { name: 'TV', icon: "tv.svg" },
  { name: 'Washing machine', icon: "washing_machine.svg" },
  { name: 'Wifi', icon: "wifi.svg" }
]

amenities_data.each do |data|
  amenity = Amenity.create!(name: data[:name], icon: data[:icon], description: data[:description])
end

user = User.create!(
  email: "test1@gmail.com",
  password: "123456",
  name: Faker::Lorem.unique.sentence(word_count: 3),
  address_1: Faker::Address.street_address,
  address_2: Faker::Address.street_name,
  city: Faker::Address.city,
  state: Faker::Address.state,
  country: Faker::Address.country
)
user.picture.attach(io: File.open("db/images/0.jpg"), filename: user.name)

19.times do |i|
  random_user = User.create!({
    email: "test#{i + 2}@gmail.com",
    password: "123456",
    name: Faker::Lorem.unique.sentence(word_count: 3),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country
  })
  random_user.picture.attach(io: File.open("db/images/#{i+1}.jpg"), filename: random_user.name)
end
6.times do |i|
  property = Property.create!({
    name: Faker::Lorem.unique.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 10),
    headline: Faker::Lorem.unique.sentence(word_count: 6),
    address_1: Faker::Address.street_address,
    address_2: Faker::Address.street_name,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: Faker::Address.country,
    price: Money.from_amount(40, "USD"),
    bedroom_count: (2..5).to_a.sample,
    bed_count: (4..10).to_a.sample,
    guest_count: (1..20).to_a.sample,
    bathroom_count: (1..4).to_a.sample
  })

  property.images.attach(io: File.open("db/images/#{i+1}.jpg"), filename: property.name)
  property.images.attach(io: File.open("db/images/7.jpg"), filename: property.name)
  property.images.attach(io: File.open("db/images/8.jpg"), filename: property.name)
  property.images.attach(io: File.open("db/images/9.jpg"), filename: property.name)
  property.images.attach(io: File.open("db/images/10.jpg"), filename: property.name)
  property.images.attach(io: File.open("db/images/11.jpg"), filename: property.name)
  property.images.attach(io: File.open("db/images/12.jpg"), filename: property.name)


  amenity_set = Set.new
  ((10..(amenities_data.length() - 1)).to_a.sample).times do
    amenity = Amenity.all.sample
    unless amenity_set.include?(amenity.id)
      property.amenities << amenity
      amenity_set << amenity.id
    end
  end
  ((5..10).to_a.sample).times do
    Review.create!({
      content: Faker::Lorem.paragraph(sentence_count: 10),
      cleanliness_rating: (1..5).to_a.sample,
      accuracy_rating: (1..5).to_a.sample,
      checkin_rating: (1..5).to_a.sample,
      communication_rating: (1..5).to_a.sample,
      location_rating: (1..5).to_a.sample,
      value_rating: (1..5).to_a.sample,
      property: property,
      user: User.all.sample
    })
  end
end
