class CreateAdvisements < ActiveRecord::Migration[5.2]
  def change
    create_table :advisements do |t|
      t.references :advisement_degree, foreign_key: true
      t.references :researcher, foreign_key: true
      t.references :intern, foreign_key: true
      t.boolean :supervisor_is_postdoc
      t.references :postdoc, foreign_key: true
      t.date :validity_start
      t.string :validity_end

      t.timestamps
    end
  end
end
