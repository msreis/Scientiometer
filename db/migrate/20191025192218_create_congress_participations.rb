class CreateCongressParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :congress_participations do |t|
      t.references :researcher, foreign_key: true
      t.references :congress, foreign_key: true
      t.date :year
      t.references :congress_role, foreign_key: true

      t.timestamps
    end
  end
end
