module Types
  class VerseType < Types::BaseObject
    field :id, ID, null: false
    field :audio_path, String, null: false
    field :user_id, Integer, null: false
    field :title, String, null: false
    field :competition_id, Integer, null: false
    field :vote, Types::VoteType, null: true
  end
end

