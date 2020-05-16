class PetapplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    favorites.remove_all_from_favorites(params[:adopt][:pet_id])
    flash[:notice] = "Application Submitted!"
    redirect_to '/favorites'
  end

end
