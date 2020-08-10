class CreateGrants < ActiveRecord::Migration[5.2]
  def change
    create_table :grants do |t|
      t.references :researcher, foreign_key: true
      t.references :grant_project_type, foreign_key: true
      t.references :grant_participation_type, foreign_key: true
      t.references :funding_agency, foreign_key: true
      t.string :process_number
      t.float :value_BRL
      t.float :value_USD
      t.date :validity_start
      t.date :validity_end

      t.timestamps
    end
  end
end
