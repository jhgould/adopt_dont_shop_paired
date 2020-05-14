require 'rails_helper'

RSpec.describe Favoriteslist do
  describe "#total_count" do
    it "can calculate the total number of pets" do
      shelter = create(:shelter)
      pet = shelter.pets.create!(
        image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
        name: "Bruno",
        approximate_age: "4",
        sex: "M",
        adoption_status: "Adoptable",)
      favorites = Favoriteslist.new([pet])
      expect(favorites.total_count).to eq(1)
    end
  end
end
