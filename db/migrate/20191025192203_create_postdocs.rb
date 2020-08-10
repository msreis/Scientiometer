class CreatePostdocs < ActiveRecord::Migration[5.2]
  def change
    create_table :postdocs do |t|
      t.string :name

      t.timestamps
    end
  end
end
