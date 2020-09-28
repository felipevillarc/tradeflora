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
            document_number:Faker::IDNumber.brazilian_citizen_number(formatted: true),
            phone_number: Faker::PhoneNumber.phone_number
            )

10.times do
  attributes = {name: Faker::Name.name,
                user_type: ["Pessoa física", "Pessoa jurídica"].sample,
                password: "123456",
                document_number:Faker::IDNumber.brazilian_citizen_number(formatted: true),
                phone_number:Faker::PhoneNumber.phone_number
                }
  attributes[:email]="#{attributes[:name].split.last}@teste.com"

  User.create(attributes)
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

  area_coordinates_faker = [
    { name:"Amazônica", range_lat:(-9.297093..-0.165376), range_long:(-65.171125..-52.210211) },
    { name:"Atlântico Leste", range_lat:(-12.904332..-10.925327), range_long:(-39.934120..-38.771828) },
    { name:"Atlântico Nordeste Oriental", range_lat:(-7.049664..-5.594422), range_long:(-39.119006..-35.858550) },
    { name:"Atlântico Nordeste Ocidental", range_lat:(-5.654485..-3.630362), range_long:(-45.159619..-43.433360) },
    { name:"Atlântico Sudeste", range_lat:(-21.537241..-18.205200), range_long:(-43.217002..-41.295759) },
    { name:"Atlântico Sul", range_lat:(-31.033515..-29.056450), range_long:(-53.250156..-51.883939) },
    { name:"Paraguai", range_lat:(-18.343451..-11.907992), range_long:(-57.096231..-53.901001) },
    { name:"Paraná", range_lat:(-24.945905..-21.582357), range_long:(-53.075268..-48.049063) },
    { name:"Parnaíba", range_lat:(-7.131784..-5.193976), range_long:(-43.213586..-42.593224) },
    { name:"São Francisco", range_lat:(-12.034531..-9.728735), range_long:(-43.421399..-42.119223) },
    { name:"Tocantins-Araguaia", range_lat:(-13.271896..-3.246820), range_long:(-50.530603..-46.122949) },
    { name:"Uruguai", range_lat:(-30.294418..-29.033095), range_long:(-56.032921..-54.474580) },
  ]
  area_coordinates_faker.select! {|hash| hash[:name] == basin_seed[:name]}

  attributes = {
    description: area_description_faker.sample,
    lat: rand(area_coordinates_faker.first[:range_lat]),
    long:rand(area_coordinates_faker.first[:range_long]),
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

  area_coordinates_faker = [
    { name:"Amazônica", range_lat:(-9.297093..-0.165376), range_long:(-65.171125..-52.210211) },
    { name:"Atlântico Leste", range_lat:(-12.904332..-10.925327), range_long:(-39.934120..-38.771828) },
    { name:"Atlântico Nordeste Oriental", range_lat:(-7.049664..-5.594422), range_long:(-39.119006..-35.858550) },
    { name:"Atlântico Nordeste Ocidental", range_lat:(-5.654485..-3.630362), range_long:(-45.159619..-43.433360) },
    { name:"Atlântico Sudeste", range_lat:(-21.537241..-18.205200), range_long:(-43.217002..-41.295759) },
    { name:"Atlântico Sul", range_lat:(-31.033515..-29.056450), range_long:(-53.250156..-51.883939) },
    { name:"Paraguai", range_lat:(-18.343451..-11.907992), range_long:(-57.096231..-53.901001) },
    { name:"Paraná", range_lat:(-24.945905..-21.582357), range_long:(-53.075268..-48.049063) },
    { name:"Parnaíba", range_lat:(-7.131784..-5.193976), range_long:(-43.213586..-42.593224) },
    { name:"São Francisco", range_lat:(-12.034531..-9.728735), range_long:(-43.421399..-42.119223) },
    { name:"Tocantins-Araguaia", range_lat:(-13.271896..-3.246820), range_long:(-50.530603..-46.122949) },
    { name:"Uruguai", range_lat:(-30.294418..-29.033095), range_long:(-56.032921..-54.474580) },
  ]
  area_coordinates_faker.select! {|hash| hash[:name] == basin_seed[:name]}

  attributes = {
    description: area_description_faker.sample,
    lat: rand(area_coordinates_faker.first[:range_lat]),
    long:rand(area_coordinates_faker.first[:range_long]),
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
