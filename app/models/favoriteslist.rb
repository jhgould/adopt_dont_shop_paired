class Favoriteslist
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def total_count
    @contents.count
  end

  def add_favorite(pet)
    @contents << pet
  end

  def remove_from_favorites(pet)
    @contents.reject!{ |pet_hash| pet_hash["id"] == pet.id }
  end

  def clear_all
    @contents.clear
  end
end
