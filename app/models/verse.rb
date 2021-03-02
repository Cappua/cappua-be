class Verse < ApplicationRecord
  validates_presence_of :audio_path,
                        :user_id,
                        :title,
                        :competition_id

  belongs_to :user
  belongs_to :competition
  has_many :votes

  class << self
    def last_month_winner
      Verse.joins(:competition, :votes)
        .where(competitions: { month: 1.month.ago.month })
        .group(:id)
        .order(Arel.sql('count(votes.id) desc'))
        .first
    end

    def top_three
      Verse.joins(:competition, :votes)
        .where(competitions: { month: Time.now.month })
        .group(:id)
        .order(Arel.sql('count(votes.id) desc'))
        .limit(3)
    end
  end
end
