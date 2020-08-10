class CreateResponsibleMultiusers < ActiveRecord::Migration[5.2]
  def change
    create_table :responsible_multiusers do |t|
      t.references :researcher, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
