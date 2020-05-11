class CreatePet < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image_path
      t.string :name
      t.string :approximate_age
      t.string :sex
    end
  end
end
