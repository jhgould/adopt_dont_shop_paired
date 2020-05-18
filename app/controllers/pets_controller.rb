class PetsController < ApplicationController

  def index
    if params[:adoption_status] == "true"
      @pets = Pet.all.adoptable_only
    elsif params[:adoption_status] == "false"
      @pets = Pet.all.pending_only
    else
      @pets = Pet.all.order_by_adoption_status
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @application = @pet.pet_applications.where(approved: true)
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.pets.create!(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.destroy(params[:id])
    favorites.remove_from_favorites(pet.id)
    redirect_to "/pets"
  end

  def pending
    pet = Pet.find(params[:id])
    if params[:app_id]
      application = PetApplication.where(application_id: params[:app_id], pet_id: pet.id)
      application.update(approved: true)
    end
    pet.update!(adoption_status: false)
    redirect_to "/pets/#{pet.id}"
  end

  def adoptable
    pet = Pet.find(params[:id])
    pet.update!(adoption_status: true)
      if params[:app_id]
        application = PetApplication.where(application_id: params[:app_id], pet_id: pet.id)
        application.update(approved: false)
        redirect_to "/applications/#{params[:app_id]}"
      else
        redirect_to "/pets/#{pet.id}"
      end
  end

  private

  def pet_params
    params.permit(
      :name,
      :approximate_age,
      :sex,
      :image_path,
      :description
    )
  end

end
