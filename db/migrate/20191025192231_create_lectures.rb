class CreateLectures < ActiveRecord::Migration[5.2]
  def change
    create_table :lectures do |t|
      t.string :name
      t.integer :lecture_count
      t.integer :workload
      t.references :postgraduate_program, foreign_key: true
      t.references :institution, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
