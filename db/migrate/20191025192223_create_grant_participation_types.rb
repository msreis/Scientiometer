class CreateGrantParticipationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :grant_participation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
