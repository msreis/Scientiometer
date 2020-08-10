class CreateMultiusers < ActiveRecord::Migration[5.2]
  def change
    create_table :multiusers do |t|
      t.string :model
      t.string :manufacturer
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end
