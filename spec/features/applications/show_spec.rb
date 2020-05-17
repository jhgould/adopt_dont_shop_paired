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
      name: "Spike",
      approximate_age: "4",
      sex: "M",)
    @application = create(:application)
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

    PetApplication.create(application_id: @application.id, pet_id: @pet1.id)
    PetApplication.create(application_id: @application.id, pet_id: @pet2.id)
    PetApplication.create(application_id: @application2.id, pet_id: @pet2.id)
    PetApplication.create(application_id: @application3.id, pet_id: @pet2.id)
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

  it "application can be approved" do

    visit "/applications/#{@application.id}"

    within ".pet-#{@pet1.id}" do
      click_link "Approve Application"
    end

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption status: Pending")
    expect(page).to have_content("#{@pet1.name} is on hold for #{@application.name}")
  end

  it "approve more than one application for a single person" do
    visit "/applications/#{@application.id}"

    within ".pet-#{@pet1.id}" do
      click_link "Approve Application"
    end

    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content("Adoption status: Pending")
    expect(page).to have_content("#{@pet1.name} is on hold for #{@application.name}")

    visit "/applications/#{@application.id}"

    within ".pet-#{@pet2.id}" do
      click_link "Approve Application"
    end

    expect(current_path).to eq("/pets/#{@pet2.id}")
    expect(page).to have_content("Adoption status: Pending")
    expect(page).to have_content("#{@pet2.name} is on hold for #{@application.name}")
  end

    it "user can revoke an application" do

      visit "/applications/#{@application.id}"

      within ".pet-#{@pet2.id}" do
        click_link "Approve Application"
      end

      visit "/applications/#{@application.id}"
      within ".pet-#{@pet2.id}" do
        expect(page).to_not have_content("Approve Application")
        click_link "Revoke Application"
      end

      expect(current_path).to eq("/applications/#{@application.id}")

      within ".pet-#{@pet2.id}" do
        expect(page).to have_content("Approve Application")
        expect(page).to_not have_content("Revoke Application")
        click_link "#{@pet2.name}"
      end

      expect(page).to have_content("Adoption status: Adoptable")
      expect(page).to_not have_content("#{@pet2.name} is on hold for #{@application.name}")
    end
end
