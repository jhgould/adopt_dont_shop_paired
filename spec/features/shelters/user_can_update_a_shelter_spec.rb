require './spec/rails_helper'

RSpec.describe "shelter edit page", type: :feature do

  before(:each) do
    @shelter1 = Shelter.create(name: "Angels With Paws", address: "2540 Youngfield St", city: "Lakewood", state: "CO", zip: "80215")
    @shelter2 = Shelter.create(name: "MaxFund Dog Shelter", address: "1005 Galapago", city: "Denver", state: "CO", zip: "80204")
  end

  it "user goes to edit page after clicking 'Update Shelter'" do
    visit "/shelters/#{@shelter1.id}"
    click_link "update-shelter-#{@shelter1.id}"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")
  end

  it "user can access the edit page from the shelters index" do
    visit "/shelters"
    click_link "update-shelter-#{@shelter1.id}"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")
  end

  it "user can update the shelter " do
    visit "/shelters/#{@shelter1.id}/edit"
    fill_in "address", with: "123 main st"
    fill_in "state", with: "NM"
    fill_in "zip", with: "12345"
    click_button "Submit"

    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content("123 main st")
  end
end
