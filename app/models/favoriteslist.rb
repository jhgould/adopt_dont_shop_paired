class Favoriteslist
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || []
  end

  def total_count
    @contents.count
  end

  def add_favorite(favorite)
    @contents << favorite
  end
end
