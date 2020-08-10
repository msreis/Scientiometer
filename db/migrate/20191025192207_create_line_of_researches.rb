class CreateLineOfResearches < ActiveRecord::Migration[5.2]
  def change
    create_table :line_of_researches do |t|
      t.string :name

      t.timestamps
    end
  end
end
