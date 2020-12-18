class RemoveCnpqLevelIdFromProductivityGrants < ActiveRecord::Migration[5.2]
  def change
    remove_reference :productivity_grants, :cnpq_level, index: true, foreign_key: true
  end
end
