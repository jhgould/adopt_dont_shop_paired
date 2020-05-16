class PetapplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents)
  end
end
