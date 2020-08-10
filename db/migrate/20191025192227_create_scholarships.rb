class CreateScholarships < ActiveRecord::Migration[5.2]
  def change
    create_table :scholarships do |t|
      t.references :advisement, foreign_key: true
      t.references :funding_agency, foreign_key: true
      t.string :process_number
      t.float :total_value_BRL
      t.float :total_value_USD
      t.float :technical_reserve_BRL
      t.date :validity_start
      t.date :validity_end

      t.timestamps
    end
  end
end
