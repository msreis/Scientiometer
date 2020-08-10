class MultiuserSubject < ApplicationRecord
  belongs_to :subject
  belongs_to :multiuser
end
