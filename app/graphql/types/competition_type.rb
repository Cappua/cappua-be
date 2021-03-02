module Types
  class CompetitionType < Types::BaseObject
    field :id, ID, null: false
    field :track_path, String, null: false
    field :month, Integer, null: false
    field :year, Integer, null: false
    field :description, String, null: true
    field :genre, String, null: true
    field :rules, String, null: true
    field :image, String, null: true
    field :title, String, null: true
    field :verses, [Types::VerseType], null: true
  end
end
