class Shelter < ApplicationRecord
  has_many :pets,
  dependent: :destroy
  has_many :reviews,
  dependent: :destroy
  validates_presence_of :name

  def pet_count
    pets.count
  end

  def self.order_by_num_adopatable
    left_outer_joins(:pets)
    .where(:pets => {:adoption_status => true})
    .group(:id)
    .order('COUNT(shelter_id) DESC')
  end

  def self.order_by_name
    order("name")
  end

  def has_pending_pets
    pets.any?{ |pet| pet.adoption_status == false }
  end

end
