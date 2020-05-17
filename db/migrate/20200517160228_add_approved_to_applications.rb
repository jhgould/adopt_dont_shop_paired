class AddApprovedToApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :approved, :boolean
  end
end
