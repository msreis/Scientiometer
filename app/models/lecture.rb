class Lecture < ApplicationRecord
  belongs_to :postgraduate_program
  belongs_to :institution
end
