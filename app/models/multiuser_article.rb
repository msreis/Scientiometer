class MultiuserArticle < ApplicationRecord
  belongs_to :article
  belongs_to :multiuser
end
