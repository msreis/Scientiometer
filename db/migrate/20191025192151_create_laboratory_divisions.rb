class CreateLaboratoryDivisions < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratory_divisions do |t|
      t.string :name

      t.timestamps
    end
  end
end
