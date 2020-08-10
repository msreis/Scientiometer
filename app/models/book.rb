class Book < ApplicationRecord
  belongs_to :qualis
  belongs_to :collaboration_type
end
