require './spec/rails_helper'

RSpec.describe "shelter delete", type: :feature do

  before(:each) do
    @shelter1 = Shelter.create(name: "Angels With Paws", address: "2540 Youngfield St", city: "Lakewood", state: "CO", zip: "80215")
    @shelter2 = Shelter.create(name: "MaxFund Dog Shelter", address: "1005 Galapago", city: "Denver", state: "CO", zip: "80204")
    @pet = Pet.create(image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
                      name: "Bruno",
                      description: "Best dog ever.",
                      approximate_age: "4",
                      sex: "M",
                      shelter_id: @shelter2.id,)
    @application = create(:application)
    PetApplication.create(application_id: @application.id, pet_id: @pet.id)
  end

  it "deletes the shelter when user clicks delete" do
    visit "/shelters/#{@shelter1.id}"
    click_on "Delete Shelter"
    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter1.name)
  end

  it "user can delete from the shelters index" do
    visit "/shelters"
    click_on "delete-shelter-#{@shelter2.id}"
    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter2.name)
  end

  it "Shelters with Pets that have pending status cannot be Deleted" do
    visit "/applications/#{@application.id}"

    within ".pet-#{@pet.id}" do
      click_link "Approve Application"
    end

    visit "/shelters"
    click_on "delete-shelter-#{@shelter2.id}"
    expect(page).to have_content("Shelters with pending pets cannot be deleted.")
    expect(page).to have_content(@shelter1.name)

    visit "/shelters/#{@shelter1.id}"
    click_on "Delete Shelter"
    expect(page).to have_content("Shelters with pending pets cannot be deleted.")
    expect(page).to have_content(@shelter1.name)
  end

end

# I can not delete that shelter
# Either:
# - there is no button visible for me to delete the shelter
# - if I click on the delete link for deleting a shelter, I see a flash message indicating that the shelter can not be deleted.
