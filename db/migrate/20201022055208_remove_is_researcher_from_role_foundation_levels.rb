class RemoveIsResearcherFromRoleFoundationLevels < ActiveRecord::Migration[5.2]
  def change
    remove_column :role_foundation_levels, :is_researcher, :boolean
  end
end
