class Scholarship < ApplicationRecord
  belongs_to :advisement
  belongs_to :funding_agency
end
