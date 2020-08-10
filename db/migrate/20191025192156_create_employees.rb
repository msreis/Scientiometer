class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.boolean :is_foundation
      t.references :laboratory, foreign_key: true
      t.references :role_foundation_level, foreign_key: true
      t.references :title, foreign_key: true

      t.timestamps
    end
  end
end
