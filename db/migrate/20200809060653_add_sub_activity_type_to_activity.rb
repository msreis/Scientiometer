class AddSubActivityTypeToActivity < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :activities, :sub_activity_types
  end
end
