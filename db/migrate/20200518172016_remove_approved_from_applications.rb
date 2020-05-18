class RemoveApprovedFromApplications < ActiveRecord::Migration[5.1]
  def change
    remove_column :applications, :approved, :boolean
  end
end
