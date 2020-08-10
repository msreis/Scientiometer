class CreateScientometricIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :scientometric_indices do |t|
      t.integer :citations_wos
      t.float :h_index_wos
      t.integer :citations_gs
      t.float :h_index_gs
      t.references :researcher, foreign_key: true
      t.references :primary_line_of_research, index: true, foreign_key: {to_table: :line_of_researches}
      t.references :secondary_line_of_research, index: true, foreign_key: {to_table: :line_of_researches}
      t.date :year

      t.timestamps
    end
  end
end
