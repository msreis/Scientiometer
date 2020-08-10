class AddSubmittedToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :submitted, :boolean
  end
end
