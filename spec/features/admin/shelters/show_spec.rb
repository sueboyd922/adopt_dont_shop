require "rails_helper"

RSpec.describe "admin shelter show page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", full_address: "13 Main St, Aurora, CO, 22439", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", full_address: "21 Grove St, Harlingen, TX, 56567", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", full_address: "1452 8th Ave, Denver, CO, 21039", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)

    @pet_3 = @shelter_1.pets.create(name: "Sherman", breed: "maine coon", age: 7, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: "Lucy", breed: "beagle", age: 2, adoptable: true)

    @pet_5 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)

    @application_1 = Application.create!(name: "Anita Barker", street_address: "2468 Park Blvd.", city: "Denver", state: "CO", zipcode: "80202", status: "Pending")
    @application_2 = Application.create!(name: "Frodo Baggins", street_address: "1 Shire Ave", city: "Denver", state: "CO", zipcode: "80202", status: "Rejected")

    @pet_app_1 = PetApplication.create(pet: @pet_1, application: @application_1)
    @pet_app_2 = PetApplication.create(pet: @pet_2, application: @application_1)
    @pet_app_3 = PetApplication.create(pet: @pet_3, application: @application_1)
    @pet_app_4 = PetApplication.create(pet: @pet_1, application: @application_2)
    @pet_app_5 = PetApplication.create(pet: @pet_4, application: @application_2)
  end

  it "has the shelters name and location" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.full_address)
    expect(page).not_to have_content(@shelter_1.foster_program)
  end

  it "has a section for statistics that shows the average age of all adoptable pets in a shelter" do
    visit "/admin/shelters/#{@shelter_1.id}"

    within ".statistics" do
      expect(page).to have_content("Average age of adoptable pets currently at this shelter is #{@shelter_1.average_age}")
    end
  end
  it "shows the number of adoptable pets in the statistics section" do
    visit "/admin/shelters/#{@shelter_1.id}"

    within ".statistics" do
      expect(page).to have_content("There are #{@shelter_1.adoptable_pet_count} adoptable pets at this shelter!")
    end
  end
  it "shows the number of pets that have been adopted in the statistics section" do
    visit "/admin/shelters/#{@shelter_1.id}"

    within ".statistics" do
      expect(page).to have_content("#{@shelter_1.adopted_pet_count} pets have been adopted from this shelter")
    end
  end

  it 'has a section of pets on pending applications not yet marked approved or rejected' do
    visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to  have_content(@pet_1.name)
      expect(page).to  have_content(@pet_2.name)
      expect(page).to  have_content(@pet_3.name)


    visit "/admin/applications/#{@application_1.id}"
      within ".pet_app-#{@pet_app_1.id}" do
        click_on("Approve")
      end

    visit "/admin/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).not_to have_content(@pet_1.name)
    
  end
end
