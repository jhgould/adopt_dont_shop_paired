require './spec/rails_helper'

RSpec.describe "pet delete", type: :feature do

  before(:each) do
    @shelter = Shelter.create(name: "MaxFund Dog Shelter", address: "1005 Galapago", city: "Denver", state: "CO", zip: "80204")
    @pet = Pet.create(image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
                      name: "Bruno",
                      description: "Best dog ever.",
                      approximate_age: "4",
                      sex: "M",
                      shelter_id: @shelter.id,
                      adoption_status: "Adoptable")
  end

  it "deletes the pet when user clicks delete" do
    visit "/pets/#{@pet.id}"
    click_on "Delete Pet"
    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@pet.name)
  end

  it "user can delete a pet from the pets index" do
    visit "/pets"
    click_link "delete-pet-#{@pet.id}"
    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@pet.name)
  end

  it "user can delete a pet from the shelter pets index and it is removed from favorites as well" do
    visit "/pets/#{@pet.id}"
    click_link "Favorite Pet"

    visit "/shelters/#{@shelter.id}/pets"
    click_link "delete-pet-#{@pet.id}"
    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@pet.name)

    visit "/favorites"
    expect(page).to_not have_content(@pet.name)
  end

  it "user cannot delete a pet if it has a pending/approved application" do
    application = create(:application)
    PetApplication.create(application_id: application.id, pet_id: @pet.id)
    visit "/applications/#{application.id}"

    within ".pet-#{@pet.id}" do
      click_link "Approve Application"
    end

    visit "/pets"
    click_link "delete-pet-#{@pet.id}"
    expect(page).to have_content("Pets with approved/pending applications cannot be deleted")
    expect(page).to have_content(@pet.name)

    visit "/pets/#{@pet.id}"
    click_on "Delete Pet"
    expect(page).to have_content("Pets with approved/pending applications cannot be deleted")
    expect(page).to have_content(@pet.name)

    visit "/shelters/#{@shelter.id}/pets"
    click_link "delete-pet-#{@pet.id}"
    expect(page).to have_content("Pets with approved/pending applications cannot be deleted")
    expect(page).to have_content(@pet.name)

  end

end
