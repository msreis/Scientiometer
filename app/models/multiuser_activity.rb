class MultiuserActivity < ApplicationRecord
  belongs_to :activity
  belongs_to :multiuser
end
