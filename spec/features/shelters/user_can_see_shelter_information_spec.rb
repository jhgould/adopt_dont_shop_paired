require './spec/rails_helper'

RSpec.describe "shelter show page", type: :feature do

  before :each do
    @shelter1 = Shelter.create(name: "Angels With Paws", address: "2540 Youngfield St", city: "Lakewood", state: "CO", zip: "80215")
    @shelter2 = Shelter.create(name: "MaxFund Dog Shelter", address: "1005 Galapago", city: "Denver", state: "CO", zip: "80204")
    @pet1 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      adoption_status: "Adoptable",
      sex: "M",
      shelter_id: @shelter1.id)
    @pet2 = Pet.create(
      image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
      name: "Woody",
      approximate_age: "2",
      adoption_status: "Adoptable",
      sex: "F",
      shelter_id: @shelter2.id)
    @review_1 = Review.create(title: "Great Shelter",
                              rating: 5,
                              content: "This shelter was very clean",
                              image_path: "",
                              shelter_id: @shelter2.id)
    @review_2 = Review.create(title: "Horrible Shelter",
                              rating: 1,
                              content: "They were mean to the dogs",
                              image_path: "",
                              shelter_id: @shelter2.id)
    @review_3 = Review.create(title: "Average Shelter",
                              rating: 1,
                              content: "They only had cats",
                              image_path: "",
                              shelter_id: @shelter1.id)
  end

  it "user can see the name, address, city, state and zip of the shelter" do
    visit "/shelters/#{@shelter1.id}"
    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter1.address)
    expect(page).to have_content(@shelter1.city)
    expect(page).to have_content(@shelter1.state)
    expect(page).to have_content(@shelter1.zip)

    visit "/shelters/#{@shelter2.id}"
    expect(page).to have_content(@shelter2.name)
    expect(page).to have_content(@shelter2.address)
    expect(page).to have_content(@shelter2.city)
    expect(page).to have_content(@shelter2.state)
    expect(page).to have_content(@shelter2.zip)
  end

  it "user can access the shelter show page from the shelter index" do
    visit "/shelters"
    click_link "#{@shelter1.name}"
    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    visit "/shelters"
    click_link "#{@shelter2.name}"
    expect(current_path).to eq("/shelters/#{@shelter2.id}")
  end

  it "user can access the shelter show page from the pets index" do
    visit "/pets"
    click_link "#{@shelter1.name}"
    expect(current_path).to eq("/shelters/#{@shelter1.id}")

    visit "/pets"
    click_link "#{@shelter2.name}"
    expect(current_path).to eq("/shelters/#{@shelter2.id}")
  end

  it "user can see all reviews for a given shelter" do
    visit "/shelters/#{@shelter2.id}"

    expect(page).to have_content(@review_1.title)
    expect(page).to have_content(@review_1.rating)
    expect(page).to have_content(@review_1.content)
    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_2.rating)
    expect(page).to have_content(@review_2.content)
    expect(page).to_not have_content(@review_3.title)
    expect(page).to_not have_content(@review_3.rating)
    expect(page).to_not have_content(@review_3.content)


  end


end
