class ResponsibleMultiuser < ApplicationRecord
  belongs_to :researcher
  belongs_to :multiuser
end
