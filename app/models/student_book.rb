class StudentBook < ApplicationRecord
  belongs_to :book
  belongs_to :intern
end
