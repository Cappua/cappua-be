class User < ApplicationRecord
  validates :email, uniqueness: true
  validates_presence_of :name, 
                        :user_sub,
                        :image

  has_many :verses
  has_many :votes
  has_many :user_votes, through: :votes
end
