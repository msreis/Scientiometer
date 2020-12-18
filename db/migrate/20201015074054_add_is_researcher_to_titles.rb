class AddIsResearcherToTitles < ActiveRecord::Migration[5.2]
  def change
    add_column :titles, :is_researcher, :boolean, default: false
  end
end
