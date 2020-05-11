class ChangeAdoptionStatusToBooleanInPets < ActiveRecord::Migration[5.1]

  def change
    Pet.where(adoption_status: 'Adoptable').update_all(adoption_status: true)
    Pet.where(adoption_status: 'Pending').update_all(adoption_status: false)
    Pet.where(adoption_status: nil).update_all(adoption_status: false)
    change_column :pets, :adoption_status, 'boolean USING CAST(adoption_status AS boolean)'
  end

end
