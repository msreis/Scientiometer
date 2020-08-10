class CreateMultiuserTheses < ActiveRecord::Migration[5.2]
  def change
    create_table :multiuser_theses do |t|
      t.references :thesis, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
