class CreateResearcherPapers < ActiveRecord::Migration[5.2]
  def change
    create_table :researcher_papers do |t|
      t.references :article, foreign_key: true
      t.references :researcher, foreign_key: true
      t.boolean :first_author
      t.boolean :last_author
      t.boolean :corresponding_author

      t.timestamps
    end
  end
end
