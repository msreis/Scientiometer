class CreateFundingAgencies < ActiveRecord::Migration[5.2]
  def change
    create_table :funding_agencies do |t|
      t.string :name

      t.timestamps
    end
  end
end
