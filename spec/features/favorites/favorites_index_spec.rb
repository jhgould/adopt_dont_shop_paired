require "rails_helper"

RSpec.describe "favorites index page", type: :feature do
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

  describe "user can see all favorited animals on index page" do
    it "displays all pets that were favorited and pets name/image" do
      visit "/pets/#{@pet1.id}"
      click_link "Favorite Pet"

      visit "/pets/#{@pet2.id}"
      click_link "Favorite Pet"

      click_link 'Total Favorites: 2'

      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)

      click_link "#{@pet1.name}"

      expect(current_path).to eq("/pets/#{@pet1.id}")
    end
  end

  it "user can remove from favorites from the favorites index" do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Pet"
    visit "/pets/#{@pet2.id}"
    click_link "Favorite Pet"
    visit '/favorites'
    within "#pet_#{@pet1.id}" do
      click_link "Remove From Favorites"
    end
    expect(current_path).to eq("/favorites")
    expect(page).to_not have_css("#pet_#{@pet1.id}")
    expect(page).to have_css("#pet_#{@pet2.id}")
    expect(page).to have_content("Total Favorites: 1")
  end

  it "displays that there are no favorited pets on the favorites page" do
    visit "/favorites"

    expect(page).to have_content("You have not favorited any pets")
    expect(page).to have_content("Total Favorites: 0")

  end
end
