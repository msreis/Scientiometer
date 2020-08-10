class PostdocBook < ApplicationRecord
  belongs_to :book
  belongs_to :postdoc
  belongs_to :submission
end
