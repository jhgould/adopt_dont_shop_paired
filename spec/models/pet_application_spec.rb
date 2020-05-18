require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  it "can find applicants name" do
    shelter = create(:shelter)
    pet1 = shelter.pets.create(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",)
    application = Application.create!(name: "Zack",
                           address: "123",
                            city: "Denver",
                            state: "CO",
                            zip: "80203",
                            phone_number: "444-4444",
                            description: "idk some string")

    pet_application = PetApplication.create(application_id: application.id, pet_id: pet1.id)

    expect(PetApplication.find_applicant_name).to eq("Zack")
  end


end
