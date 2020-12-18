class AddGrantCurrentnessToGrant < ActiveRecord::Migration[5.2]
  def change
    add_reference :grants, :grant_currentness, index: true, foreign_key: true
  end
end
