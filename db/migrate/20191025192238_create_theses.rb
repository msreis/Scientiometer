class CreateTheses < ActiveRecord::Migration[5.2]
  def change
    create_table :theses do |t|
      t.date :finish_year
      t.references :institution, foreign_key: true
      t.date :delivery_date
      t.references :advisement, foreign_key: true

      t.timestamps
    end
  end
end
