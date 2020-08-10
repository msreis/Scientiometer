class CreateSubActivityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :sub_activity_types do |t|
      t.string :name
      t.references :activity_type, foreign_key: true

      t.timestamps
    end
  end
end
