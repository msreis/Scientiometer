class CreateGrantExtensions < ActiveRecord::Migration[5.2]
  def change
    create_table :grant_extensions do |t|
      t.references :grant, foreign_key: true
      t.float :value_BRL
      t.float :value_USD
      t.date :validity_start
      t.date :validity_end

      t.timestamps
    end
  end
end
