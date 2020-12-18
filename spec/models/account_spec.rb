require 'rails_helper'

RSpec.describe Account, type: :model do
  it 'give me an account' do
    account = create(:account)
    account
  end
end
