class Shelter < ApplicationRecord
  has_many :pets,
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

end
