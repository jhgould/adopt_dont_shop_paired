require './spec/rails_helper'

RSpec.describe "favorites", type: :feature do

  before :each do
    @shelter = Shelter.create(name: "Angels With Paws")
    @pet1 = @shelter.pets.create!(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",
      adoption_status: "Adoptable",)
    @pet2 = @shelter.pets.create!(
      image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
      name: "Woody",
      approximate_age: "2",
      sex: "F",
      adoption_status: "Adoptable",)
    @pet3 = @shelter.pets.create!(
      image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
      name: "Jim",
      approximate_age: "2",
      sex: "F",
      adoption_status: false,)
    @pet4 = @shelter.pets.create!(
      image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
      name: "Koa",
      approximate_age: "2",
      sex: "F",
      adoption_status: "Adoptable",)
  end

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

  describe "favorite creation" do
    it "pet can be added to favorites" do
      visit "/pets/#{@pet1.id}"
      click_link "Favorite Pet"
      expect(current_path).to eq("/pets/#{@pet1.id}")
      expect(page).to have_content("#{@pet1.name} added to favorites.")
      expect(page).to have_content("Total Favorites: 1")
    end

    it "pet can't be added to favorites more than once" do
      visit "/pets/#{@pet1.id}"
      click_link "Favorite Pet"
      expect(page).to_not have_content("Favorite Pet")
      click_link("Remove From Favorites")
      expect(current_path).to eq("/pets/#{@pet1.id}")
      expect(page).to have_content("#{@pet1.name} removed from favorites.")
      expect(page).to have_content("Favorite Pet")
      expect(page).to have_content("Favorites: 0")
    end
  end

end
