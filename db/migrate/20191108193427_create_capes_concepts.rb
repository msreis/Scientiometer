class CreateCapesConcepts < ActiveRecord::Migration[5.2]
  def change
    create_table :capes_concepts do |t|
      t.string :concept

      t.timestamps
    end
  end
end
