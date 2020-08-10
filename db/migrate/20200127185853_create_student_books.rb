class CreateStudentBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :student_books do |t|
      t.references :book, foreign_key: true
      t.references :intern, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
