# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "Seeding..."


# ================BASINS=================

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
# basins_ids = []
# basins_names = []
# Basin.all.each do |basin|
#   basins_ids << basin[:id]
#   basins_names << basin[:name]
# end
puts "Basins seeded!"




# ==========USERS=======================


puts "Clearing Users table"
User.destroy_all

puts "Seeding Users table"
User.create(name: "João Rural",
            user_type: "Pessoa física",
            email: "joao@teste.com",
            password: "123456",
            document_number:rand(10_000_000_000..99_999_999_999).to_s,
            phone_number:rand(1..10000).to_s
            )
User.create(name: "Carlos Empresário",
            user_type: "Pessoa jurídica",
            email: "carlos@teste.com",
            password: "123456",
            document_number:rand(10_000_000_000..99_999_999_999).to_s,
            phone_number:rand(1..10000).to_s
            )

10.times do
  User.create(name: Faker::Name.name,
              user_type: ["Pessoa física", "Pessoa jurídica"].sample,
              email: Faker::Internet.email,
              password: "123456",
              document_number:rand(10_000_000_000..99_999_999_999).to_s,
              phone_number:rand(1..10000).to_s
              )
end

# Variables for support in other seed operations
user_joao_rural = User.find_by(name: "João Rural")
user_carlos_empresario = User.find_by(name: "Carlos Empresário")

users_ids = []
User.all.each do |user|
  users_ids << user[:id]
end

users_ids.delete(user_joao_rural[:id])
users_ids.delete(user_carlos_empresario[:id])



puts "Users seeded!"





# ===============AREAS===============



puts "Clearing Areas table"
Area.destroy_all

puts "Seeding Areas table"



# Area seeds for test user João Rural

4.times do
  basin_seed = Basin.all.sample

  area_description_faker = [
    "Uma área rural disponível para reflorestamento",
    "Área para reflorestamento na Bacia #{basin_seed[:name]}",
    "Área para reflorestamento.",
    "Disponibilizo área na Bacia #{basin_seed[:name]}"
  ]

  attributes = {
    description: area_description_faker.sample,
    lat: Faker::Address.latitude,
    long:Faker::Address.longitude,
    user_id: user_joao_rural[:id],
    basin_id: basin_seed[:id]
  }
  Area.create(attributes)
end


# Area seeds for aleatory users

10.times do
  basin_seed = Basin.all.sample

  area_description_faker = [
    "Uma área rural disponível para reflorestamento",
    "Área para reflorestamento na Bacia #{basin_seed[:name]}",
    "Área para reflorestamento.",
    "Disponibilizo área na Bacia #{basin_seed[:name]}"
  ]

  attributes = {
    description: area_description_faker.sample,
    lat: Faker::Address.latitude,
    long:Faker::Address.longitude,
    user_id: users_ids.sample,
    basin_id: basin_seed[:id]
  }
  Area.create(attributes)
end

# Variables for support in other seed operations

joao_rural_areas = Area.where(user_id: user_joao_rural[:id])

areas_ids = []
Area.all.each do |area|
  areas_ids << area[:id]
end

puts "Areas seeded!"



# ==================TRADES=================




puts "Clearing Trades table"
Trade.destroy_all

puts "Seeding Trades table"

trade_status_options = ["Opções a definir"]

# Proposals for João Rural
3.times do
  attributes = {
    status: trade_status_options.sample,
    viewed: [true, false].sample,
    user_id: user_carlos_empresario[:id],
    area_id: joao_rural_areas.sample[:id]
  }
  Trade.create(attributes)
end


# 5.times do
#   attributes = {
#     status: trade_status_options.sample,
#     viewed: [true, false].sample,
#     user_id: users_ids.sample,
#     area_id: areas_ids.sample
#   }
#   Trade.create(attributes)
# end
puts "Trades seeded!"
