require './spec/rails_helper'

RSpec.describe "shelter index", type: :feature do
  it "user goes to new shelter page when clicking 'New Shelter'" do
    visit "/shelters/"
    click_link "New Shelter"

    expect(current_path).to eq("/shelters/new")
  end

  it "creates a new shelter when user submits" do
    visit "/shelters/new"
    fill_in "name", with: "New Shelter"
    fill_in "address", with: "2540 Youngfield St"
    fill_in "state", with: "NM"
    fill_in "zip", with: "12345"
    click_button "Create Shelter"

    expect(current_path).to eq("/shelters")
    visit("/shelters")
    expect(page).to have_content("New Shelter")
  end
end
