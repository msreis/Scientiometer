class AddCategoriesToRoleFoundationLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :role_foundation_levels, :categories, :text, default: [].to_yaml
  end
end
