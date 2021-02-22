require 'rails_helper'

describe Verse, type: :model do
  describe 'relationships' do
    it do
      should belong_to :user
      should have_many :votes
      should belong_to :competition
    end
  end
end
