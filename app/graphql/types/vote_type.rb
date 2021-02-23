module Types
  class VoteType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: false
    field :verse_id, Integer, null: false
  end
end