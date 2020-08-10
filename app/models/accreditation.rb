class Accreditation < ApplicationRecord
  belongs_to :researcher
  belongs_to :postgraduate_program
  belongs_to :institution
end
