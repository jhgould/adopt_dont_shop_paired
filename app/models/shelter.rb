class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates_presence_of :name

  def pet_count
    pets.count
  end

  def self.order_by_num_adopatable
    left_outer_joins(:pets)
    .group(:id)
    .order('COUNT(pets.adoption_status = true) DESC')
  end

  def self.order_by_name
    order("name")
  end

  def self.top_shelters
    joins(:reviews)
    .group(:id)
    .order('avg(reviews.rating) DESC')
    .limit(3)
  end

  def has_pending_pets
    Shelter.joins(:pets)
            .where("shelters.id = ?", id)
            .where("pets.adoption_status = false")
            .exists?
  end

  def average_rating
    reviews.average(:rating)
  end

  def number_of_applications
    pets.joins(:applications).count
  end

end
