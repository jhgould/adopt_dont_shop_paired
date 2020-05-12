# When I click on this link, I am taken to a new review path
# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review

require 'rails_helper'

RSpec.describe "review creation", type: :feature  do
  before :each do
    @shelter = create(:shelter)
  end

  it "user can create access the review creation form from a shelter show page" do
    visit "/shelters/#{@shelter.id}"
    click_link "New Review"
    expect(current_path).to eq("/shelters/#{@shelter.id}/reviews/new")
  end

  it "user can create a shelter from the new review page" do
    visit "/shelters/#{@shelter.id}/reviews/new"
    fill_in "title", with: "Great Shelter"
    fill_in "rating", with: 5
    fill_in "content", with: "This is a great shelter"
    expect(page).to have_content("Image URL: ")
    click_link "Submit Review"
    expect(current_path).to eq("/shelters/#{@shelter.id}")
    expect(page).to have_content("Great Shelter")
    expect(page).to have_content("5")
    expect(page).to have_content("Rating: 5")
    expect(page).to have_content("This is a great shelter")
  end
end
