class ApprovalHistory < ApplicationRecord
  belongs_to :account
  belongs_to :submission
  belongs_to :approval_action
end
