class CreateMinisteredClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :ministered_classes do |t|
      t.references :postgraduate_program, foreign_key: true
      t.references :institution, foreign_key: true
      t.references :subject, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
