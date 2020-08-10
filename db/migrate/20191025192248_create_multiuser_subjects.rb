class CreateMultiuserSubjects < ActiveRecord::Migration[5.2]
  def change
    create_table :multiuser_subjects do |t|
      t.references :subject, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
