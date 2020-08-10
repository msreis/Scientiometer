class Advisement < ApplicationRecord
  belongs_to :advisement_degree
  belongs_to :researcher
  belongs_to :intern
end
