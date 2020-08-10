class CreateStudentPapers < ActiveRecord::Migration[5.2]
  def change
    create_table :student_papers do |t|
      t.references :article, foreign_key: true
      t.references :intern, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
