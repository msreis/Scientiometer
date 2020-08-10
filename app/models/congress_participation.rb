class CongressParticipation < ApplicationRecord
  belongs_to :researcher
  belongs_to :congress
  belongs_to :congress_role
end
