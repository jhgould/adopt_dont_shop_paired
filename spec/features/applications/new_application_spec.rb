require './spec/rails_helper'

RSpec.describe "applications", type: :feature do
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

  it "user can access application form from the favorties index" do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Pet"
    visit "/pets/#{@pet2.id}"
    click_link "Favorite Pet"
    visit "/pets/#{@pet3.id}"
    click_link "Favorite Pet"
    visit "/favorites"
    click_link "Adopt Favorite Pets"
    expect(current_path).to eq("/applications/new")
  end

  it "user can create an application" do
    visit "/pets/#{@pet1.id}"
    click_link "Favorite Pet"
    visit "/pets/#{@pet2.id}"
    click_link "Favorite Pet"
    visit "/pets/#{@pet3.id}"
    click_link "Favorite Pet"
    visit "/applications/new"
    check "adopt_pet_id_#{@pet1.id}"
    check "adopt_pet_id_#{@pet2.id}"
    fill_in "Name", with: "Jack"
    fill_in "Address", with: "1223"
    fill_in "City", with: "Lakewood"
    fill_in "State", with: "CO"
    fill_in "Zip", with: "80215"
    fill_in "Phone Number", with: "555-5555"
    fill_in "Description", with: "Im awesome."
    click_button "Submit"
    expect(page).to have_content("Application Submitted!")
    expect(current_path).to eq("/favorites")
    within ".pets_list" do
      expect(page).to have_content("#{@pet3.name}")
      expect(page).to_not have_content("#{@pet1.name}")
      expect(page).to_not have_content("#{@pet2.name}")
    end
  end

  it "incomplete application" do
    visit "/applications/new"
    click_button "Submit"
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Please fill out the required fields.")
  end

end
