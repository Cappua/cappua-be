module Types
  class VerseType < Types::BaseObject
    field :id, ID, null: false
    field :audio_path, String, null: false
    field :user_id, Integer, null: false
    field :title, String, null: false
    field :competition_id, Integer, null: false
    field :vote, Types::VoteType, null: true
    field :upvoted, Boolean, null: false do
      argument :user_id, Integer, required: true
    end
    field :vote_count, Integer, null: false

    def upvoted(user_id:)
      object.votes.where(user_id: user_id) != []
    end

    def vote_count
      object.votes.count
    end
  end
end
