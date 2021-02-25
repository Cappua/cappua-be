require 'rails_helper'

describe Verse, type: :model do
  describe 'relationships' do
    it do
      should belong_to :user
      should have_many :votes
      should belong_to :competition
    end
  end

  describe 'methods' do
    it "last_month_winner" do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      competition = create(:competition, month: 1)
      verse1 = create(:verse, user_id: user1.id, competition_id: competition.id)
      verse2 = create(:verse, user_id: user2.id, competition_id: competition.id)
      verse3 = create(:verse, user_id: user3.id, competition_id: competition.id)
      vote1 = Vote.create(verse_id: verse2.id, user_id: user1.id)
      vote2 = Vote.create(verse_id: verse3.id, user_id: user1.id)
      vote3 = Vote.create(verse_id: verse3.id, user_id: user2.id)
      vote4 = Vote.create(verse_id: verse1.id, user_id: user3.id)

      expect(Verse.last_month_winner).to eq(verse3)
    end
  end
end
