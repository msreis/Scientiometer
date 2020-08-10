# frozen_string_literal: true

require 'time'

class CurrentYear
  def self.current_year
    Date.new(Date.today.year.to_i, 1, 1)
  end
end
