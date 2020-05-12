class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Please fill out required fields."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  private

  def review_params
    params.permit(
      :title,
      :rating,
      :content,
      :image_path,
    )
  end
end
