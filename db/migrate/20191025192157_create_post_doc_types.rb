class CreatePostDocTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :post_doc_types do |t|
      t.string :postdoc_type

      t.timestamps
    end
  end
end
