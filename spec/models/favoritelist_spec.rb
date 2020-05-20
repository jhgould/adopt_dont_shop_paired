require 'rails_helper'

RSpec.describe Favoriteslist do

  before :each do
    @shelter = create(:shelter)
    @pet1 = @shelter.pets.create!(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",
      adoption_status: "Adoptable",)
    @pet2 = @shelter.pets.create!(
      image_path: "https://cdn.pixabay.com/photo/2015/06/08/15/02/pug-801826_1280.jpg",
      name: "Bruno",
      approximate_age: "4",
      sex: "M",
      adoption_status: "Adoptable",)
    @favorites = Favoriteslist.new([@pet1.id.to_s])
  end

  describe "methods" do
    it "total_count" do
      expect(@favorites.total_count).to eq(1)
    end

    it "add_favorite" do
      @favorites.add_favorite(@pet2.id.to_s)
      expect(@favorites.total_count).to eq(2)
    end

    it "remove_from_favorites" do
      @favorites.add_favorite(@pet2.id.to_s)
      @favorites.remove_from_favorites(@pet2.id.to_s)
      expect(@favorites.total_count).to eq(1)
      @favorites.remove_from_favorites(@pet1.id.to_s)
      expect(@favorites.total_count).to eq(0)
    end

    it "remove_all_from_favorites" do
      @favorites.add_favorite(@pet2.id.to_s)
      @favorites.remove_all_from_favorites([@pet1.id.to_s, @pet2.id.to_s])
      expect(@favorites.total_count).to eq(0)
    end

    it "clear_all" do
      @favorites.clear_all
      expect(@favorites.total_count).to eq(0)
    end

    it "has_pet" do
      expect(@favorites.has_pet?(@pet1)).to eq(true)
      expect(@favorites.has_pet?(@pet2)).to eq(false)
    end
  end
end
