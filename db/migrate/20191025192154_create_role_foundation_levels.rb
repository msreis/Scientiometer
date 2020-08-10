class CreateRoleFoundationLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :role_foundation_levels do |t|
      t.string :description

      t.timestamps
    end
  end
end
