class AddZipToApplications < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :zip, :string
  end
end
