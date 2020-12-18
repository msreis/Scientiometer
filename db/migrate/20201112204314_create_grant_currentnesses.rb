class CreateGrantCurrentnesses < ActiveRecord::Migration[5.2]
  def change
    create_table :grant_currentnesses do |t|
      t.string :name

      t.timestamps
    end
  end
end
