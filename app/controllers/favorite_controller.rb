class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:id])
    favorites.add_favorite(pet)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} added to favorites."
    redirect_to "/pets/#{params[:id]}"
  end

  def index

  end

  def destroy
    pet = Pet.find(params[:id])
    favorites.remove_from_favorites(pet)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} removed from favorites."
    redirect_to "/pets/#{params[:id]}"
  end
end
