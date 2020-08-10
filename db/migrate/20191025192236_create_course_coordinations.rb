class CreateCourseCoordinations < ActiveRecord::Migration[5.2]
  def change
    create_table :course_coordinations do |t|
      t.string :name
      t.references :course_classification, foreign_key: true
      t.references :coordination_degree, foreign_key: true
      t.integer :workload
      t.date :year

      t.timestamps
    end
  end
end
