class CreateProductivityGrants < ActiveRecord::Migration[5.2]
  def change
    create_table :productivity_grants do |t|
      t.references :cnpq_level, foreign_key: true
      t.boolean :is_fb
      t.date :validity_start
      t.date :validity_end
      t.references :researcher, foreign_key: true

      t.timestamps
    end
  end
end
