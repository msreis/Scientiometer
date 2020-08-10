class AddReprovedToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :reproved, :boolean
  end
end
