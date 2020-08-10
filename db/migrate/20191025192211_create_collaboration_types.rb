class CreateCollaborationTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :collaboration_types do |t|
      t.string :collaboration

      t.timestamps
    end
  end
end
