class Verse < ApplicationRecord
  belongs_to :user
  belongs_to :track
  has_many :votes
end
