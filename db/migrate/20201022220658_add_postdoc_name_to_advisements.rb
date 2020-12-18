class AddPostdocNameToAdvisements < ActiveRecord::Migration[5.2]
  def change
    add_column :advisements, :postdoc_name, :string
  end
end
