class PetapplicationsController < ApplicationController

  def new
    @pets = Pet.find(favorites.contents)
  end

  def create
    application = Application.new(application_params)
    if application.save
      params[:adopt][:pet_id].each do |pet_id|
        PetApplication.create(pet_id: pet_id, application_id: application.id)
      end
      favorites.remove_all_from_favorites(params[:adopt][:pet_id])
      flash[:notice] = "Application Submitted!"
      redirect_to '/favorites'
    else
      flash[:notice] = "Please fill out the required fields."
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
  end

  def index
    @pet = Pet.find(params[:pet_id])
  end

  private

  def application_params
    params.permit(
      :pets,
      :name,
      :address,
      :city,
      :state,
      :zip,
      :phone_number,
      :description)
  end

end
