class CreateMultiuserGrants < ActiveRecord::Migration[5.2]
  def change
    create_table :multiuser_grants do |t|
      t.references :grant, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
