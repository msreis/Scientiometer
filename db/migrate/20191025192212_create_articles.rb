class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :DOI_url
      t.string :reference
      t.references :qualis, foreign_key: true
      t.float :impact_factor
      t.references :collaboration_type, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
