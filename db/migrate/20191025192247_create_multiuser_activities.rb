class CreateMultiuserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :multiuser_activities do |t|
      t.references :activity, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
