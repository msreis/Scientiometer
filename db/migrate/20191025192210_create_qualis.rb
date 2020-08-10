class CreateQualis < ActiveRecord::Migration[5.2]
  def change
    create_table :qualis do |t|
      t.string :qualis

      t.timestamps
    end
  end
end
