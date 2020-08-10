class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :description
      t.integer :access_level

      t.timestamps
    end
  end
end
