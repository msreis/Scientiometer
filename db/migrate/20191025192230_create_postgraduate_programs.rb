class CreatePostgraduatePrograms < ActiveRecord::Migration[5.2]
  def change
    create_table :postgraduate_programs do |t|
      t.string :name

      t.timestamps
    end
  end
end
