require 'rails_helper'

RSpec.describe Pet do

  before :each do
    @shelter = create(:shelter)
    @pet1 = @shelter.pets.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",
      adoption_status: false)
    @pet2 = @shelter.pets.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bucky",
      approximate_age: "4",
      sex: "M",)
    @application = create(:application)
    PetApplication.create(application_id: @application.id, pet_id: @pet1.id, approved: true)
  end

  describe 'relationships' do
    it {should belong_to :shelter}
    it {should have_many :pet_applications}
    it {should have_many(:applications).through(:pet_applications)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'methods' do
    describe "class methods" do
      it "adoptable_only" do
        expect(Pet.adoptable_only).to eq([@pet2])
      end

      it "pending_only" do
        expect(Pet.pending_only).to eq([@pet1])
      end

      it "order_by_adoption_status" do
        expect(Pet.order_by_adoption_status).to eq([@pet2, @pet1])
      end

      it "all_with_application" do
        expect(Pet.all_with_application).to eq([@pet1])
      end

      it "has_approved_pets" do
        expect(Pet.has_approved_pets?).to eq(true)
      end
    end

    describe "instance methods" do
      it "has_other_approved_application" do
        expect(@pet1.has_other_approved_application?(@application.id)).to eq(false)
      end
      it "has_approved_application" do
        expect(@pet1.has_approved_application?).to eq(true)
        expect(@pet2.has_approved_application?).to eq(false)
      end
    end
  end
end
