require 'rails_helper'

describe Vote, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:verse_id)}
    it {should validate_presence_of(:user_id)}
  end
  describe 'relationships' do
    it do
      should belong_to :verse
      should belong_to :user
      should belong_to(:user_vote).class_name('Verse')
    end
  end
end
