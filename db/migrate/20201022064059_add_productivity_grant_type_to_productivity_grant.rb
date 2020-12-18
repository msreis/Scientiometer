class AddProductivityGrantTypeToProductivityGrant < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :productivity_grants, :productivity_grant_types
  end
end
