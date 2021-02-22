class Verse < ApplicationRecord
  belongs_to :user
  belongs_to :competition
  has_many :votes
end
