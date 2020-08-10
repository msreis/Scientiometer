class Employee < ApplicationRecord
  belongs_to :laboratory
  belongs_to :role_foundation_level
  belongs_to :title
end
