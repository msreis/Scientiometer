class CreateApprovalActions < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_actions do |t|
      t.string :name

      t.timestamps
    end
  end
end
