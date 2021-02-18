class Vote < ApplicationRecord
  belongs_to :verse
  belongs_to :user
  belongs_to :user_vote, foreign_key: 'verse_id', class_name: 'Verse'

end
