class CreateResearchers < ActiveRecord::Migration[5.2]
  def change
    create_table :researchers do |t|
      t.string :researcher_id
      t.string :ORCID
      t.date :ingress_date
      t.string :email
      t.boolean :is_lab_director
      t.string :code
      t.references :post_doc_type, foreign_key: true
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
