class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:id])
    favorites.add_favorite(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} added to favorites."
    redirect_to "/pets/#{params[:id]}"
  end
end
