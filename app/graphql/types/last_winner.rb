module Types
  class LastWinner < Types::BaseObject
    field :audio_path, String, null: false
    # field :name, String, null: false
    # field :description, String, null: false
    field :competition, Types::CompetitionType, null: false
    field :user, Types::UserType, null: false
  end
end
