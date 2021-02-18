class User < ApplicationRecord
  has_many :verses
  has_many :votes
  has_many :user_votes, through: :votes
end
