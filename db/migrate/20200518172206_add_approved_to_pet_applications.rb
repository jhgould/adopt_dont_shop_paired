class AddApprovedToPetApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :pet_applications, :approved, :boolean
  end
end
