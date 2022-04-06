# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
application_1 = Application.create!(name: "Anita Barker", street_address: "2468 Park Blvd.", city: "Denver", state: "CO", zipcode: "80202")
application_2 = Application.create!(name: "Bob Barker", street_address: "1357 20th st.", city: "Golden", state: "CO", zipcode: "80209", description: "I'm a great pet parent!", status: "Pending")
application_3 = Application.create!(name: "Doug Shruggs", street_address: "2024 Baker Blvd", city: "Littleton", state: "CO", zipcode: "80120", description: "I'm a great dog dad!", status: "Pending")
application_4 = Application.create!(name: "Steve Darwin", street_address: "135 McCord Road", city: "Dallas", state: "TX", zipcode: 75001, description: "I really want a pet", status: "Approved")
application_5 = Application.create!(name: "Rocco Ragazza", street_address: "1212 Waddle St.", city: "Medford", state: "MA", zipcode: 11027, description: "I really, really, want a pet", status: "Approved")
application_6 = Application.create!(name: "Garbonzo Bean", street_address: "888 Humus Drive", city: "Sacramento", state: "CA", zipcode: 90411, description: "A pet would be nice", status: "Pending")

shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
shelter_4 = Shelter.create(name: "Dumb Friends League", city: "Boulder, CO", foster_program: true, rank: 1)

pet_1 = Pet.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true, shelter_id: shelter_1.id)
pet_2 = Pet.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true, shelter_id: shelter_1.id)
pet_3 = Pet.create!(name: "Ann", breed: "ragdoll", age: 3, adoptable: false, shelter_id: shelter_3.id)
pet_4 = Pet.create!(name: "Purrdy", breed: "persian", age: 6, adoptable: true, shelter_id: shelter_3.id)
pet_5 = Pet.create!(name: "Staniel", breed: "sheepadoodle", age: 2, adoptable: true, shelter_id: shelter_4.id)
pet_6 = Pet.create!(name: "Brodan", breed: "German Shorthair Pointer", age: 5, adoptable: true, shelter_id: shelter_4.id)
pet_7 = Pet.create!(name: "Brophy", breed: "German Shorthair Pointer", age: 3, adoptable: true, shelter_id: shelter_4.id)
pet_8 = Pet.create!(name: "Brostephanie", breed: "German Shorthair Pointer", age: 8, adoptable: true, shelter_id: shelter_2.id)

PetApplication.create!(pet: pet_1, application: application_2)
PetApplication.create!(pet: pet_2, application: application_2)

PetApplication.create!(pet: pet_3, application: application_3)
PetApplication.create!(pet: pet_4, application: application_3)
