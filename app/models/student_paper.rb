class StudentPaper < ApplicationRecord
  belongs_to :article
  belongs_to :intern
end
