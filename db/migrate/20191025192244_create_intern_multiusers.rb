class CreateInternMultiusers < ActiveRecord::Migration[5.2]
  def change
    create_table :intern_multiusers do |t|
      t.references :intern, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
