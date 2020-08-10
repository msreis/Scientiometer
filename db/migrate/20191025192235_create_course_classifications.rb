class CreateCourseClassifications < ActiveRecord::Migration[5.2]
  def change
    create_table :course_classifications do |t|
      t.string :classification

      t.timestamps
    end
  end
end
