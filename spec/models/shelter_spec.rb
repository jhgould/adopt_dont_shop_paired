require 'rails_helper'

RSpec.describe Shelter do
  describe 'relationships' do
    it {should have_many :pets}
    it {should have_many :reviews}
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

    it "has_pending_pets" do
      shelter = create(:shelter)
      shelter.pets.create(name: "Dog", adoption_status: false)

      expect(shelter.has_pending_pets).to eq(true)
    end

    it "average_rating" do
      shelter = create(:shelter)
      shelter.reviews.create(title: "Great Shelter",
                                rating: 5,
                                content: "This shelter was very clean",
                                image_path: "",
                                )
      shelter.reviews.create(title: "Bad Shelter",
                                rating: 1,
                                content: "This shelter was very clean",
                                image_path: "",
                                )

      expect(shelter.average_rating).to eq(3)
    end

    it "number_of_applications" do
      shelter = create(:shelter)
      pet1 = shelter.pets.create(name: "Dog")
      application1 = create(:application)
      application2 = create(:application)
      PetApplication.create(application_id: application1.id, pet_id: pet1.id)
      PetApplication.create(application_id: application2.id, pet_id: pet1.id)

      expect(shelter.number_of_applications).to eq(2)
    end

    it "order_by_name" do
      shelter1 = Shelter.create(name: "Z")
      shelter2 = Shelter.create(name: "A")
      expect(Shelter.order_by_name).to eq([shelter2, shelter1])
    end

    it "order_by_num_adopatable" do
      shelter1 = Shelter.create(name: "Z")
      shelter2 = Shelter.create(name: "A")
      shelter1.pets.create(
        image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
        name: "Bruno",
        approximate_age: "4",
        sex: "M",
        adoption_status: false)
      shelter2.pets.create(
        image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
        name: "Bruno",
        approximate_age: "4",
        sex: "M",
        adoption_status: true)
      expect(Shelter.order_by_num_adopatable).to eq([shelter2])
    end

    it "top_shelters" do
      shelter1 = Shelter.create(name: "Z")
      shelter2 = Shelter.create(name: "B")
      shelter3 = Shelter.create(name: "A")
      shelter1.reviews.create!(title: "Great", rating: 3, content: "This place was awesome")
      shelter2.reviews.create!(title: "Great", rating: 2, content: "This place was awesome")
      shelter3.reviews.create!(title: "Great", rating: 4, content: "This place was awesome")
      shelter3.reviews.create!(title: "Great", rating: 5, content: "This place was awesome")
      expect(Shelter.top_shelters).to eq([shelter3, shelter1, shelter2])
    end
  end
end
