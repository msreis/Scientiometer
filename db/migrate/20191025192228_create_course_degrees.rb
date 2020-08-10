class CreateCourseDegrees < ActiveRecord::Migration[5.2]
  def change
    create_table :course_degrees do |t|
      t.string :degree

      t.timestamps
    end
  end
end
