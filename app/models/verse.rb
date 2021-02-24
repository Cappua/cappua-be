class Verse < ApplicationRecord
  belongs_to :user
  belongs_to :competition
  has_many :votes

  def self.last_month_winner
    competition = Competition.find_by(month: previous_month)
    vote_count = competition.verses.max do |verse|
      verse.votes.count
    end
    vote_count
  end

  def self.previous_month
    # 1.month.ago
    current_month = Time.now.mon
    if current_month == 1
      return 12
    else
      current_month - 1
    end
  end
end
