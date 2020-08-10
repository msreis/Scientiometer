class CreateAccreditations < ActiveRecord::Migration[5.2]
  def change
    create_table :accreditations do |t|
      t.references :researcher, foreign_key: true
      t.references :postgraduate_program, foreign_key: true
      t.references :institution, foreign_key: true
      t.references :course_degree, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
