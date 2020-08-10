class CreateResearcherBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :researcher_books do |t|
      t.references :book, foreign_key: true
      t.references :researcher, foreign_key: true
      t.boolean :first_author
      t.boolean :last_author
      t.boolean :corresponding_author

      t.timestamps
    end
  end
end
