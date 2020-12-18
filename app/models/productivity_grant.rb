class ProductivityGrant < ApplicationRecord
  belongs_to :researcher
  belongs_to :productivity_grant_type
end
