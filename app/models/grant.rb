class Grant < ApplicationRecord
  belongs_to :researcher
  belongs_to :grant_project_type
  belongs_to :grant_participation_type
  belongs_to :funding_agency
end
