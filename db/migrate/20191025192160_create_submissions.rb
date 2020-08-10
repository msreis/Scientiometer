class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.references :account, foreign_key: true
      t.boolean :accepted
      t.datetime :last_modified
      t.date :date

      t.timestamps
    end
  end
end
