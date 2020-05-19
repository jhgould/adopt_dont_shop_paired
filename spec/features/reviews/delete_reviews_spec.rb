require 'rails_helper'

RSpec.describe "delete review", type: :feature  do
  before :each do
    @shelter = create(:shelter)
    @review_1 = @shelter.reviews.create!(
                                title: "Great",
                                rating: 5,
                                content: "This place was awesome")
    @review_2 = @shelter.reviews.create!(
                                title: "good",
                                rating: 3,
                                content: "This place was ehh")
  end
  it "user can delete reviews" do
    visit "/shelters/#{@shelter.id}"

    click_link "delete_review_#{@review_1.id}"

    expect(current_path).to eq("/shelters/#{@shelter.id}")

    expect(page).to_not have_content(@review_1.title)
    expect(page).to have_content(@review_2.title)
  end



end

# When I delete a shelter review I am returned to the shelter's show page
# And I should no longer see that shelter review
