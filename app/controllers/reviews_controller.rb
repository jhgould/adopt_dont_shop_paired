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

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter_id}"
    else
      flash[:notice] = "Please fill out required fields."
      redirect_to "/reviews/#{review.id}/edit"
    end
  end

  def destroy
    shelter_id = Review.find(params[:id]).shelter_id
    Review.destroy(params[:id])
    redirect_to "/shelters/#{shelter_id}"
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
