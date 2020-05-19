class SheltersController < ApplicationController

  def index
    if params[:order_by_num_adopatable] == "true"
      @shelters = Shelter.order_by_num_adopatable
    elsif params[:order_by_name] == "true"
      @shelters = Shelter.order_by_name
    else
      @shelters = Shelter.all
    end
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    empty_params = shelter_params.select{|param, value| value.empty?}
    if !empty_params.empty?
      flash[:notice] = "Please fill in #{empty_params.keys.join(", ")}"
      redirect_to '/shelters/new'
    else
      Shelter.create!(shelter_params)
      redirect_to '/shelters'
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.has_pending_pets
      flash[:notice] = "Shelters with pending pets cannot be deleted."
      redirect_back(fallback_location: root_path)
    else
      Shelter.destroy(params[:id])
      redirect_to '/shelters'
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    empty_params = shelter_params.select{|param, value| value.empty?}
    shelter = Shelter.find(params[:id])
    if !empty_params.empty?
      flash[:notice] = "Please fill in #{empty_params.keys.join(", ")}"
      redirect_to "/shelters/#{shelter.id}/edit"
    else
      shelter.update!(shelter_params)
      redirect_to "/shelters/#{shelter.id}"
    end
  end

  def pets
    @shelter = Shelter.find(params[:id])
    if params[:adoption_status] == "true"
      @pets = @shelter.pets.adoptable_only
    elsif params[:adoption_status] == "false"
      @pets = @shelter.pets.pending_only
    else
      @pets = @shelter.pets.order_by_adoption_status
    end
  end

  private

  def shelter_params
    params.permit(
        :name,
        :address,
        :city,
        :state,
        :zip
      )
  end
end
