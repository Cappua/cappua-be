class Vote < ApplicationRecord
  validates_presence_of :verse_id,
                        :user_id

  belongs_to :verse
  belongs_to :user
  belongs_to :user_vote, foreign_key: 'verse_id', class_name: 'Verse'
end
