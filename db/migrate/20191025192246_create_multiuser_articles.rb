class CreateMultiuserArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :multiuser_articles do |t|
      t.references :article, foreign_key: true
      t.references :multiuser, foreign_key: true
      t.date :year

      t.timestamps
    end
  end
end
