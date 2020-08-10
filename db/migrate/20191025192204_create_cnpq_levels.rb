class CreateCnpqLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :cnpq_levels do |t|
      t.string :level

      t.timestamps
    end
  end
end
