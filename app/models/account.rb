# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :profile
  has_secure_password
  validates :username, presence: true, uniqueness: true
  serialize :completed_steps, Hash


  def add_step(step)
    self[:completed_steps] = {} unless completed_steps

    completed_steps[step] = true
  end
end
