class Activity < ApplicationRecord
  belongs_to :activity_type
  belongs_to :sub_activity_type
end
