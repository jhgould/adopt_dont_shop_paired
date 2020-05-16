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
    @contents.reject!{ |pet_id| pet_id  == pet }
  end

  def remove_all_from_favorites(pet_ids)
    pet_ids.each { |pet_id| remove_from_favorites(pet_id) }
  end

  def clear_all
    @contents.clear
  end
end
