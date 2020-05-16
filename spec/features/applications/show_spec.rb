require "rails_helper"

RSpec.describe "application show page" do
  before :each do
    @shelter = create(:shelter)
    @pet1 = @shelter.pets.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",)
    @pet2 = @shelter.pets.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",)
    @application = create(:application)
    PetApplication.create(application_id: @application.id, pet_id: @pet1.id)
    PetApplication.create(application_id: @application.id, pet_id: @pet2.id)
  end

  it "has all information for the application" do
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.phone_number)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end
end
