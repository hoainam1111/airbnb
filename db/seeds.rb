# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(
  email: "nam@gmail.com",
  password: "123456"
)
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
      user: user
    })
  end
end
