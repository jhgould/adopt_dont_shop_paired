require 'rails_helper'

RSpec.describe "review update", type: :feature  do

  before :each do
    @shelter = create(:shelter)
    @review_1 = @shelter.reviews.create!(
                                  title: "Great",
                                  rating: 5,
                                  content: "This place was awesome")
  end
  describe "user can edit an exsiting review" do
    it "Edit reivew takes user to an update review form" do
      visit "/shelters/#{@shelter.id}"
      click_link "update_review_#{@review_1.id}"
      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

    end

    it "user can update from update form" do
      visit "/reviews/#{@review_1.id}/edit"
      # expect(page).to have_content("#{@review_1.title}")
      # expect(page).to have_content("#{@review_1.rating}")
      # expect(page).to have_content("#{@review_1.content}")

      fill_in "title", with: "Average Shelter"
      fill_in "rating", with: 3
      fill_in "content", with: "Only had cats"

      click_button "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter.id}")
      expect(page).to have_content("Average Shelter")
      expect(page).to have_content("Rating:3")
      expect(page).to have_content("Only had cats")

    end
    it "user will get flash notice if required fields are not filled in" do
      visit "/reviews/#{@review_1.id}/edit"

      fill_in "title", with: ""

      click_button "Update Review"
      expect(page).to have_content("Please fill out required fields.")
    end

  end
end
