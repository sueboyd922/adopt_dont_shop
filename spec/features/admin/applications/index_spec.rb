require 'rails_helper'


RSpec.describe 'admin applications index' do
  before (:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @pet_3 = @shelter_2.pets.create(name: "Sherman", breed: "maine coon", age: 7, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: "Lucy", breed: "beagle", age: 2, adoptable: true)

    @pet_5 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name: "Anita Barker", street_address: '2468 Park Blvd.', city: "Denver", state: "CO", zipcode: "80202", status: "Pending")
    @application_2 = Application.create!(name: "Frodo Baggins", street_address: '1 Shire Ave', city: "Denver", state: "CO", zipcode: "80202", status: "Rejected")
  end

  it 'should have links to all applications' do
    visit "/admin/applications"
    save_and_open_page
    expect(page).to have_link("Anita Barker")
  end
end
