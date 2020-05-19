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
    empty_params = pet_params.select{|param, value| value.empty?}
    shelter = Shelter.find(params[:shelter_id])
    if !empty_params.empty?
      flash[:notice] = "Please fill in #{empty_params.keys.join(", ")}"
      redirect_back(fallback_location: root_path)
    else
      shelter.pets.create!(pet_params)
      redirect_to "/shelters/#{shelter.id}/pets"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    empty_params = pet_params.select{|param, value| value.empty?}
    pet = Pet.find(params[:id])
    if !empty_params.empty?
      flash[:notice] = "Please fill in #{empty_params.keys.join(", ")}"
      redirect_to "/pets/#{pet.id}/edit"
    else
      pet.update(pet_params)
      pet.save
      redirect_to "/pets/#{pet.id}"
    end
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.has_pending_application
       flash[:notice] =  "Pets with approved/pending applications cannot be deleted"
       redirect_back(fallback_location: root_path)
    else
      Pet.destroy(params[:id])
      favorites.remove_from_favorites(pet.id.to_s)
      redirect_to "/pets"
    end
  end

  def pending
    pet = Pet.find(params[:id])
    application = PetApplication.where(application_id: params[:app_id], pet_id: pet.id)
    application.update(approved: true)
    pet.update!(adoption_status: false)
    redirect_to "/pets/#{pet.id}"
  end

  def adoptable
    pet = Pet.find(params[:id])
    pet.update!(adoption_status: true)
    application = PetApplication.where(application_id: params[:app_id], pet_id: pet.id)
    application.update(approved: false)
    redirect_to "/applications/#{params[:app_id]}"
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
