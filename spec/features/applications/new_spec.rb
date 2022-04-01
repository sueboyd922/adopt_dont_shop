require 'rails_helper'

RSpec.describe 'new application page' do
  it 'creates a new application' do
    visit '/applications/new'

    fill_in("Name", with: "Frodo Baggins")
    fill_in("Street Address", with: "1 Shire Ave")
    fill_in("City", with: "Las Vegas")
    fill_in("State", with: "NV")
    fill_in("Zipcode", with: "88901")

    click_on("Submit")
    new_app = Application.last
    expect(current_path).to eq("/applications/#{new_app.id}")
    save_and_open_page

    expect(page).to have_content("Frodo Baggins")
    expect(page).to have_content("1 Shire Ave")
    expect(page).to have_content("Las Vegas")
    expect(page).to have_content("None")
    expect(page).to have_content("Pending")
    expect(page).not_to have_content("Accepted")
  end

end