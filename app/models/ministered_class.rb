class MinisteredClass < ApplicationRecord
  belongs_to :postgraduate_program
  belongs_to :institution
  belongs_to :subject
end
