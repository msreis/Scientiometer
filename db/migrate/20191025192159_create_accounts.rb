class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :password_digest
      t.references :profile, foreign_key: true
      t.references :employee, foreign_key: true
      t.text :completed_steps

      t.timestamps
    end
  end
end
