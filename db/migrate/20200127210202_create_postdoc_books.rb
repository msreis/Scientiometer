class CreatePostdocBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :postdoc_books do |t|
      t.references :book, foreign_key: true
      t.references :postdoc, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
