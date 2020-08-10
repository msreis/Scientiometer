class CreatePostdocPapers < ActiveRecord::Migration[5.2]
  def change
    create_table :postdoc_papers do |t|
      t.references :postdoc, foreign_key: true
      t.references :article, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
