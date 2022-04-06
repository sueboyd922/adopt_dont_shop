require 'rails_helper'

RSpec.describe PetApplication do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do
    it { should belong_to :pet}
    it { should belong_to :application}
  end

  it 'sets default setting for status' do
    pet = Pet.new(name: "Lucy", age: 2, breed: "beagle", adoptable: true)
    application_1 = Application.create!(name: 'Anita Barker', street_address: '2468 Park Blvd.', city: 'Denver', state: 'CO', zipcode: '80202')
    pet_app = PetApplication.create!(pet: pet, application: application_1)

    expect(pet_app.status).to eq("Pending")
  end

  describe 'class methods' do
    before (:each) do
      @application_1 = Application.create!(
        name: 'Anita Barker',
        street_address: '2468 Park Blvd.',
        city: 'Denver',
        state: 'CO',
        zipcode: '80202',
        description: 'none',
        status: 'Pending'
        )
      @application_2 = Application.create!(
        name: 'Bob Barker',
        street_address: '1357 20th st.',
        city: 'Golden',
        state: 'CO',
        zipcode: '80209',
        description: 'na',
        status: 'pending'
        )
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    end

    it 'tells you if all of the pet applications it has are approved' do
      PetApplication.create!(pet: @pet_1, application: @application_1, status: "Approved")
      PetApplication.create!(pet: @pet_2, application: @application_1, status: "Approved")
      PetApplication.create!(pet: @pet_1, application: @application_2, status: "Rejected")
      PetApplication.create!(pet: @pet_2, application: @application_2)

      expect(@application_1.pet_applications.all_approved?).to be true
      expect(@application_2.pet_applications.all_approved?).to be false
    end

    it "tells you if the all pet applications on an application have been inspected" do
      PetApplication.create!(pet: @pet_1, application: @application_1, status: "Approved")
      PetApplication.create!(pet: @pet_2, application: @application_1)
      PetApplication.create!(pet: @pet_1, application: @application_2, status: "Rejected")
      PetApplication.create!(pet: @pet_2, application: @application_2, status: "Approved")

      expect(@application_1.pet_applications.all_inspected?).to be false
      expect(@application_2.pet_applications.all_inspected?).to be true
    end
  end
end
