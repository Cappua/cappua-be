module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :image, String, null: true
    field :user_sub, String, null: true
    field :verses, [Types::VerseType], null: true
  end
end
