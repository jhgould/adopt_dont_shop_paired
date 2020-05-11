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
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  def pending
    pet = Pet.find(params[:id])
    pet.update!(adoption_status: false)
    redirect_to "/pets/#{pet.id}"
  end

  def adoptable
    pet = Pet.find(params[:id])
    pet.update!(adoption_status: true)
    redirect_to "/pets/#{pet.id}"
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
