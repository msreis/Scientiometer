class Researcher < ApplicationRecord
  belongs_to :employee
  belongs_to :post_doc_type
end
