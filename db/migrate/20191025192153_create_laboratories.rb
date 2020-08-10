class CreateLaboratories < ActiveRecord::Migration[5.2]
  def change
    create_table :laboratories do |t|
      t.string :name
      t.references :laboratory_division, foreign_key: true

      t.timestamps
    end
  end
end
