require './spec/rails_helper'

RSpec.describe "applications index page", type: :feature do
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
    @application1 = create(:application)
    @application2 = Application.create!(name: "John",
                           address: "123",
                            city: "Denver",
                            state: "CO",
                            zip: "80203",
                            phone_number: "444-4444",
                            description: "idk some string")
    @application3 = Application.create!(name: "Zack",
                           address: "123",
                            city: "Denver",
                            state: "CO",
                            zip: "80203",
                            phone_number: "444-4444",
                            description: "idk some string")


    PetApplication.create(application_id: @application1.id, pet_id: @pet1.id)
    PetApplication.create(application_id: @application2.id, pet_id: @pet1.id)
    PetApplication.create(application_id: @application3.id, pet_id: @pet2.id)
  end

  it "a user can see all the applicatons for a pet from the pets show page" do
    visit "pets/#{@pet1.id}"

    click_link "View All Applications"
    expect(page).to have_content(@application1.name)
    expect(page).to have_content(@application2.name)
    expect(page).to_not have_content(@application3.name)

    click_link "#{@application1.name}"
    expect(current_path).to eq("/applications/#{@application1.id}")
    click_link "#{@application2.name}"
    expect(current_path).to eq("/applications/#{@application2.id}")
    click_link "#{@application3.name}"
    expect(current_path).to eq("/applications/#{@application3.id}")
  end


end
