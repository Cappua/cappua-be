require 'rails_helper'

describe Vote, type: :model do
  describe 'relationships' do
    it do
      should belong_to :verse
      should belong_to :user
      should belong_to(:user_vote).class_name('Verse')
    end
  end

  describe 'validations' do
    it do
    end
  end
end
