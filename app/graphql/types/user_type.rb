module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :image, String, null: false
    field :verse, Types::Verse, null: true
  end
end