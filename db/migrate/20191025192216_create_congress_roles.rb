class CreateCongressRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :congress_roles do |t|
      t.string :role

      t.timestamps
    end
  end
end
