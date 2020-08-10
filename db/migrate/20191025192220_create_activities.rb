class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :description
      t.integer :workload
      t.integer :duration
      t.references :activity_type, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
