require './spec/rails_helper'

RSpec.describe "pet edit page", type: :feature do

  before(:each) do
    @shelter = Shelter.create(name: "Angels With Paws", address: "2540 Youngfield St", city: "Lakewood", state: "CO", zip: "80215")
    @pet = Pet.create(image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
                      name: "Bruno",
                      description: "Best dog ever.",
                      approximate_age: "4",
                      sex: "M",
                      shelter_id: @shelter.id,
                      adoption_status: true)
    @pet2 = Pet.create(image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
                      name: "Buck",
                      description: "Best dog",
                      approximate_age: "4",
                      sex: "M",
                      shelter_id: @shelter.id,
                      adoption_status: false)
  end

  it "user goes to edit page after clicking 'Update Pet'" do
    visit "/pets/#{@pet.id}"
    click_link "Update Pet"

    expect(current_path).to eq("/pets/#{@pet.id}/edit")
  end

  it "user can update the pet " do
    visit "/pets/#{@pet.id}/edit"
    fill_in "name", with: "Kolohe"
    fill_in "image_path", with: "https://cdn.pixabay.com/photo/2016/01/29/20/54/dog-1168663_1280.jpg"
    fill_in "description", with: "cool dog"
    fill_in "approximate_age", with: "5"
    fill_in "sex", with: "F"
    click_button "Submit"

    expect(current_path).to eq("/pets/#{@pet.id}")
    expect(page).to have_content("Kolohe")
    expect(page).to have_content("cool dog")
    expect(page).to have_content("5")
    expect(page).to have_content("F")
  end

  it "user can change adoption status to pending" do
    visit "/pets/#{@pet.id}"
    click_link "Change to Adoption Pending"
    expect(page).to have_content("Adoption status: Pending")
    expect(current_path).to eq("/pets/#{@pet.id}")
  end

  it "user can change adoption status to adoptable" do
    visit "/pets/#{@pet2.id}"
    click_link "Change to Adoptable"
    expect(page).to have_content("Adoption status: Adoptable")
    expect(current_path).to eq("/pets/#{@pet2.id}")
  end

  it "user can update from the pets index" do
    visit "/pets"
    click_link "update-pet-#{@pet.id}"
    expect(current_path).to eq("/pets/#{@pet.id}/edit")
  end

  it "user can update from the shelter pets index" do
    visit "shelters/#{@shelter.id}/pets"
    click_link "update-pet-#{@pet.id}"
    expect(current_path).to eq("/pets/#{@pet.id}/edit")
  end

end
