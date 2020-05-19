class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name
  attribute :adoption_status, :boolean, default: true

  def self.adoptable_only
    where(adoption_status: :true)
  end

  def self.pending_only
    where(adoption_status: :false)
  end

  def self.order_by_adoption_status
    order("adoption_status DESC NULLS LAST ")
  end

  def self.all_with_application
    joins(:pet_applications).distinct
  end

  def has_approved_application(app_id)
    applications.any? do |application|
      application.id != app_id && pet_applications.where(application_id: application.id, pet_id: id).first.approved == true
    end
  end

  def has_pending_application
    pet_applications.any? do |application|
      application.approved == true
    end
  end


end
