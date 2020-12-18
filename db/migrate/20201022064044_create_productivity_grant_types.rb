class CreateProductivityGrantTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :productivity_grant_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
