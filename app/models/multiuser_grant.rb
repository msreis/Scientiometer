class MultiuserGrant < ApplicationRecord
  belongs_to :grant
  belongs_to :multiuser
end
