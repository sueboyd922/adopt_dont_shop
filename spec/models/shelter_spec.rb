require "rails_helper"

RSpec.describe Shelter, type: :model do
  describe "relationships" do
    it { should have_many(:pets) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:rank) }
    it { should validate_numericality_of(:rank) }
  end

  before(:each) do
    @shelter_1 = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
  end

  describe "class methods" do
    describe "#search" do
      it "returns partial matches" do
        expect(Shelter.search("Fancy")).to eq([@shelter_3])
      end
    end

    describe "#order_by_recently_created" do
      it "returns shelters with the most recently created first" do
        expect(Shelter.order_by_recently_created).to eq([@shelter_3, @shelter_2, @shelter_1])
      end
    end

    describe "#order_by_number_of_pets" do
      it "orders the shelters by number of pets they have, descending" do
        expect(Shelter.order_by_number_of_pets).to eq([@shelter_1, @shelter_3, @shelter_2])
      end
    end

    describe "#class methods" do
      it "pending_apps" do
        @pet_5 = @shelter_2.pets.create!(name: "Joey", breed: "ragdoll", age: 8, adoptable: true)

        @application_1 = Application.create!(name: "Anita Barker", street_address: "2468 Park Blvd.", city: "Denver", state: "CO", zipcode: "80202", status: "Pending")
        @application_2 = Application.create!(name: "Frodo Baggins", street_address: "1 Shire Ave", city: "Denver", state: "CO", zipcode: "80202", status: "Approved")

        PetApplication.create!(pet: @pet_1, application: @application_1)
        PetApplication.create!(pet: @pet_2, application: @application_1)
        PetApplication.create!(pet: @pet_3, application: @application_1)
        PetApplication.create!(pet: @pet_5, application: @application_2)
        PetApplication.create!(pet: @pet_5, application: @application_2)

        expect(Shelter.pending_apps).to eq([@shelter_1, @shelter_3])
      end

      it "name_and_city" do
        shelter_search = Shelter.name_and_city(@shelter_2.id).first
        expect(shelter_search.name).to eq(@shelter_2.name)
        expect(shelter_search.full_address).to eq(@shelter_2.full_address)
        # expect(shelter_search.foster_program).to eq(nil)
        # expect(shelter_search.rank).not_to eq(@shelter_2.rank)
      end
    end
  end

  describe "instance methods" do
    describe ".adoptable_pets" do
      it "only returns pets that are adoptable" do
        expect(@shelter_1.adoptable_pets).to eq([@pet_2, @pet_4])
      end
    end

    describe ".adoptable_pet_count" do
      it "returns count of adoptable pets" do
        expect(@shelter_1.adoptable_pet_count).to eq(2)
      end
    end

    describe ".alphabetical_pets" do
      it "returns pets associated with the given shelter in alphabetical name order" do
        expect(@shelter_1.alphabetical_pets).to eq([@pet_4, @pet_2])
      end
    end

    describe ".shelter_pets_filtered_by_age" do
      it "filters the shelter pets based on given params" do
        expect(@shelter_1.shelter_pets_filtered_by_age(5)).to eq([@pet_4])
      end
    end

    describe ".pet_count" do
      it "returns the number of pets at the given shelter" do
        expect(@shelter_1.pet_count).to eq(3)
      end
    end

    describe ".reverse_alpha_names" do
      it "returns a list of shelters in reverse alphabetical order by name" do
        expect(Shelter.reverse_alpha_names).to eq([@shelter_2, @shelter_3, @shelter_1])
      end
    end

    describe ".average_age" do
      it "returns the average age of all the pets in the shelter" do
        @shelter_1.pets.create!(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
        expect(@shelter_1.average_age).to eq(3.67)
      end
    end

    describe ".adopted_pets" do
      it "returns the count of pets that have an apporved application." do
        application_1 = Application.create!(name: "Steve Darwin", street_address: "135 McCord Road", city: "Dallas", state: "TX", zipcode: 75001, description: "I really want a pet", status: "Approved")
        application_2 = Application.create!(name: "Rocco Ragazza", street_address: "1212 Waddle St.", city: "Medford", state: "MA", zipcode: 11027, description: "I really, really, want a pet", status: "Approved")
        application_3 = Application.create!(name: "Garbonzo Bean", street_address: "888 Humus Drive", city: "Sacramento", state: "CA", zipcode: 90411, description: "A pet would be nice", status: "Pending")
        pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: application_1.id, status: "Approved")
        pet_application_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: application_2.id, status: "Approved")
        pet_application_3 = PetApplication.create!(pet_id: @pet_4.id, application_id: application_3.id, status: "Pending")
        expect(@shelter_1.adopted_pet_count).to eq(2)
      end
    end
  end
end
