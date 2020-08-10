class ProductivityGrant < ApplicationRecord
  belongs_to :cnpq_level
  belongs_to :researcher
end
