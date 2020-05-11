require 'rails_helper'

RSpec.describe Shelter do
  describe 'relationships' do
    it {should have_many :pets}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'methods' do
    it "can count pets at a shelter" do
      shelter1 = Shelter.create(name: "Angels With Paws")
      shelter2 = Shelter.create(name: "Shetler")
      shelter1.pets.create!(
        image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
        name: "Bruno",
        approximate_age: "4",
        sex: "M",)
      shelter1.pets.create!(
        image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
        name: "Woody",
        approximate_age: "2",
        sex: "F",)
      shelter2.pets.create!(
        image_path: "https://cdn.pixabay.com/photo/2015/11/17/13/13/dogue-de-bordeaux-1047521_1280.jpg",
        name: "Spike",
        approximate_age: "4",
        sex: "F",)

        expect(shelter1.pet_count).to eq(2)
        expect(shelter2.pet_count).to eq(1)
    end
  end
end
