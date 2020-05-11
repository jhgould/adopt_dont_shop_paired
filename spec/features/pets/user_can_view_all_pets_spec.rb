require './spec/rails_helper'

RSpec.describe "pets index page", type: :feature do

  before :each do
    @shelter = Shelter.create(name: "Angels With Paws")
    @pet1 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",
      adoption_status: false,
      shelter_id: @shelter.id)
    @pet2 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
      name: "Woody",
      approximate_age: "2",
      sex: "F",
      adoption_status: "Adoptable",
      shelter_id: @shelter.id)
  end

  it "user can see each pet and information on the pets index page" do
    visit "/pets"

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet1.approximate_age)
    expect(page).to have_content(@pet1.sex)
    expect(page).to have_content(@pet1.shelter.name)
    expect(page).to have_content(@pet2.name)
    expect(page).to have_content(@pet2.approximate_age)
    expect(page).to have_content(@pet2.sex)
    expect(page).to have_content(@pet2.shelter.name)
  end

  it "pets are sorted by adoption status" do
    visit "/pets"
    within(".pets_list") do
      expect(page.all('ul').last).to have_content("#{@pet1.name}")
    end
  end

  describe "user can visit the pets index from any page" do
    it "can go to pet index from the shelters index" do
      visit "/shelters"
      click_link "All Pets"

      expect(current_path).to eq("/pets")
    end

    it "can go to pet index from the shelters show page" do
      visit "/shelters/#{@shelter.id}"
      click_link "All Pets"

      expect(current_path).to eq("/pets")
    end

    it "can go to pet index from the pet show page" do
      visit "/pets/#{@pet1.id}"
      click_link "All Pets"

      expect(current_path).to eq("/pets")
    end
  end

  it "user can filter pets by adoption status" do
    visit "/pets"
    click_link "Show Adoptable Pets Only"
    expect(current_path).to eq("/pets")
    expect(page).to_not have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)

    visit "/pets"
    click_link "Show Pending Pets Only"
    expect(current_path).to eq("/pets")
    expect(page).to have_content(@pet1.name)
    expect(page).to_not have_content(@pet2.name)
  end
end
