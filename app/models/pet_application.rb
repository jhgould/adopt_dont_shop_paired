class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application
  attribute :approved, :boolean, default: false


  def self.find_applicant_name
    select('applications.*').joins(:application).pluck(:name).first
  end

end
