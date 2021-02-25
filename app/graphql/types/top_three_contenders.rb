module Types
  class TopThreeContenders < Types::BaseObject
    field :audio_path, String, null: false
    field :title, String, null: false
    field :user, Types::UserType, null: false
    field :votes, Types::VoteType, null: false
  end
end
