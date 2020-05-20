class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
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
    order("adoption_status DESC NULLS LAST")
  end

  def self.all_with_application
    joins(:pet_applications).distinct
  end

  def self.has_approved_pets?
    joins(:pet_applications)
    .where("pet_applications.approved = true").exists?
  end

  def has_other_approved_application?(app_id)
    PetApplication.where("pet_id = ?", id)
                    .where("application_id <> ?", app_id)
                    .where(approved: true)
                    .exists?
  end

  def has_approved_application?
    Pet.joins(:pet_applications)
        .where("pets.id = ? AND pet_applications.approved = true", id)
        .exists?
  end


end
