class ResearcherBook < ApplicationRecord
  belongs_to :book
  belongs_to :researcher
end
