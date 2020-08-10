class CreateMultiuserInLabs < ActiveRecord::Migration[5.2]
  def change
    create_table :multiuser_in_labs do |t|
      t.references :multiuser, foreign_key: true
      t.references :laboratory, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
