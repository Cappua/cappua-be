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
    before :each do
      @user1 = create(:user)
      @user2 = create(:user)
      @user3 = create(:user)
      @user4 = create(:user)
      @user5 = create(:user)

      @competition1 = create(:competition, month: 1)

      @verse1 = create(:verse, user_id: @user1.id, competition_id: @competition1.id)
      @verse2 = create(:verse, user_id: @user2.id, competition_id: @competition1.id)
      @verse3 = create(:verse, user_id: @user3.id, competition_id: @competition1.id)
      @verse4 = create(:verse, user_id: @user4.id, competition_id: @competition1.id)
      @verse5 = create(:verse, user_id: @user5.id, competition_id: @competition1.id)

      @vote1 = Vote.create(verse_id: @verse2.id, user_id: @user1.id)
      @vote2 = Vote.create(verse_id: @verse3.id, user_id: @user1.id)
      @vote3 = Vote.create(verse_id: @verse3.id, user_id: @user2.id)
      @vote4 = Vote.create(verse_id: @verse1.id, user_id: @user3.id)
      @vote5 = Vote.create(verse_id: @verse3.id, user_id: @user4.id)
      @vote6 = Vote.create(verse_id: @verse2.id, user_id: @user5.id)
    end

    it "last_month_winner" do
      expect(Verse.last_month_winner).to eq(@verse3)
    end

    it "top_three" do
      competition2 = create(:competition, month: Verse.current_month)
      verse6 = create(:verse, user_id: @user1.id, competition_id: competition2.id)
      verse7 = create(:verse, user_id: @user2.id, competition_id: competition2.id)
      verse8 = create(:verse, user_id: @user3.id, competition_id: competition2.id)
      verse9 = create(:verse, user_id: @user4.id, competition_id: competition2.id)
      verse10 = create(:verse, user_id: @user5.id, competition_id: competition2.id)

      vote7 = Vote.create(verse_id: verse7.id, user_id: @user1.id)
      vote8 = Vote.create(verse_id: verse8.id, user_id: @user1.id)
      vote9 = Vote.create(verse_id: verse8.id, user_id: @user2.id)
      vote10 = Vote.create(verse_id: verse6.id, user_id: @user3.id)
      vote11 = Vote.create(verse_id: verse8.id, user_id: @user4.id)
      vote12 = Vote.create(verse_id: verse7.id, user_id: @user5.id)

      expect(Verse.top_three).to eq([verse8, verse7, verse6])
    end
  end
end
