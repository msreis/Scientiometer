class PostdocPaper < ApplicationRecord
  belongs_to :postdoc
  belongs_to :article
end
