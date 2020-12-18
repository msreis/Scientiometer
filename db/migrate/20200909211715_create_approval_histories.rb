class CreateApprovalHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_histories do |t|
      t.references :account, foreign_key: true
      t.references :submission, foreign_key: true
      t.references :approval_action, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
