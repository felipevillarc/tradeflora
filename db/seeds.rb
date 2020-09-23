# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Seeding..."

puts "Clearing Basins table"
Basin.destroy_all

puts "Seeding Basins table"
Basin.create(name: "Amazônica", lat: '0', long: '0')
Basin.create(name: "Atlântico Leste", lat: '0', long: '0')
Basin.create(name: "Atlântico Nordeste Oriental", lat: '0', long: '0')
Basin.create(name: "Atlântico Nordeste Ocidental", lat: '0', long: '0')
Basin.create(name: "Atlântico Sudeste", lat: '0', long: '0')
Basin.create(name: "Atlântico Sul", lat: '0', long: '0')
Basin.create(name: "Paraguai", lat: '0', long: '0')
Basin.create(name: "Paraná", lat: "-51.003054", long: "-20.093773")
Basin.create(name: "Parnaíba", lat: '0', long: '0')
Basin.create(name: "São Francisco", lat: '0', long: '0')
Basin.create(name: "Tocantins-Araguaia", lat: '0', long: '0')
Basin.create(name: "Uruguai", lat: '0', long: '0')
basins_ids = []
Basin.all.each do |basin|
  basins_ids << basin[:id]
end
puts "Basin seeded!"

puts "Clearing Users table"
User.destroy_all

puts "Seeding Users table"
User.create(name: "teste",
            user_type: ["Pessoa física", "Pessoa jurídica"].sample,
            email: "teste@teste.com",
            password: "123456",
            document_number:rand(10_000_000_000..99_999_999_999).to_s,
            phone_number:rand(1..10000).to_s
            )
5.times do
  User.create(name: Faker::Name.name,
              user_type: ["Pessoa física", "Pessoa jurídica"].sample,
              email: Faker::Internet.email,
              password: "123456",
              document_number:rand(10_000_000_000..99_999_999_999).to_s,
              phone_number:rand(1..10000).to_s
              )
end
users_ids = []
User.all.each do |user|
  users_ids << user[:id]
end
puts "Users seeded!"


puts "Clearing Areas table"
Area.destroy_all

puts "Seeding Areas table"
5.times do
  attributes = {
    description: Faker::Lorem.sentences(number: 2),
    lat: Faker::Address.latitude,
    long:Faker::Address.longitude,
    user_id: users_ids.sample,
    basin_id: basins_ids.sample
  }
  Area.create(attributes)
end
areas_ids = []
Area.all.each do |area|
  areas_ids << area[:id]
end

puts "Areas seeded!"


puts "Clearing Trades table"
Trade.destroy_all

puts "Seeding Trades table"

5.times do
  attributes = {
    status: ["Opções a definir"].sample,
    viewed: [true, false].sample,
    user_id: users_ids.sample,
    area_id: areas_ids.sample
  }
  Trade.create(attributes)
end
puts "Trades seeded!"
