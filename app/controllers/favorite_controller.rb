class FavoriteController < ApplicationController
  def update
    pet = Pet.find(params[:id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new(0)
    session[:favorites][pet_id_str] ||= 0
    session[:favorites][pet_id_str] = session[:favorites][pet_id_str] + 1
    flash[:notice] = "#{pet.name} added to favorites."
    redirect_to "/pets/#{params[:id]}"
  end
end
