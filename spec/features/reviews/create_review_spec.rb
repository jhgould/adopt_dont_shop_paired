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
    expect(page).to have_content("Image URL:")
    click_button"Submit Review"
    expect(current_path).to eq("/shelters/#{@shelter.id}")
    expect(page).to have_content("Great Shelter")
    expect(page).to have_content("Rating:5")
    expect(page).to have_content("This is a great shelter")
  end

  it "user cant create review without title, rating, content" do
    visit "/shelters/#{@shelter.id}/reviews/new"
    click_on "Submit Review"
    expect(page).to have_content("Please fill out required fields.")
    expect(page).to have_button("Submit Review")
  end

end

# As a visitor,
# When I fail to enter a title, a rating, and/or content in the new shelter review form, but still try to submit the form
# I see a flash message indicating that I need to fill in a title, rating, and content in order to submit a shelter review
# And I'm returned to the new form to create a new review
