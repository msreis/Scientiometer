class Lecture < ApplicationRecord
  belongs_to :postgraduate_program, optional: true
  belongs_to :institution
end
