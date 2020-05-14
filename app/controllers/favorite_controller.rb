class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:id])
    session[:favorites] ||= []
    session[:favorites] << [pet]
    flash[:notice] = "#{pet.name} added to favorites."
    redirect_to "/pets/#{params[:id]}"
  end
end
