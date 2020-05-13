require './spec/rails_helper'

RSpec.describe "favorites", type: :feature do

  describe "favorites indicator" do
    it "shows number of favorites on the nav bar" do
      visit "/shelters"
      within "nav" do
        expect(page).to have_content("Total Favorites: 0")
      end

      visit "/pets"
      within "nav" do
        expect(page).to have_content("Total Favorites: 0")
      end
    end
  end

end
