require './spec/rails_helper'

RSpec.describe "shelters index page", type: :feature do

  before :each do
    @shelter1 = Shelter.create(name: "Angels With Paws")
    @shelter2 = Shelter.create(name: "MaxFund Dog Shelter")
    @pet1 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",
      shelter_id: @shelter1.id)
    @pet2 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Buck",
      approximate_age: "6",
      sex: "M",
      shelter_id: @shelter2.id)
    @pet3 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Billy",
      approximate_age: "2",
      sex: "F",
      shelter_id: @shelter2.id)
  end

  it "can see all shelter names" do
    visit "/shelters"
    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter2.name)
  end

  describe "user can visit shelters index from any page" do
    it "can go to shelter index from pet index" do
      visit "/pets"
      click_link "All Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "can go to shelter index from shelter show page" do
      visit "/shelters/#{@shelter1.id}"
      click_link "All Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "can go to shelter index from pet show page" do
      visit "/pets/#{@pet1.id}"
      click_link "All Shelters"
      expect(current_path).to eq("/shelters")
    end
  end

  describe "shelters can be sorted" do
    it "by number of adoptable pets" do
      visit "/shelters"
      click_link "Sort by Number of Adoptable Pets"
      expect(current_path).to eq("/shelters")
      within ".shelter_list" do
        expect(page.all('.shelter').last).to have_content(@shelter1.name)
      end
    end

    it "by shelter name" do
      visit "/shelters"
      click_link "Sort by Shelter Name"
      expect(current_path).to eq("/shelters")
      within ".shelter_list" do
        expect(page.all('.shelter').last).to have_content(@shelter2.name)
      end
    end

  end

end
