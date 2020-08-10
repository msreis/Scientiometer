class CreateAdvisementDegrees < ActiveRecord::Migration[5.2]
  def change
    create_table :advisement_degrees do |t|
      t.string :degree

      t.timestamps
    end
  end
end
