class AddIsResearcherToRoleFoundationLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :role_foundation_levels, :is_researcher, :boolean, default: false
  end
end
