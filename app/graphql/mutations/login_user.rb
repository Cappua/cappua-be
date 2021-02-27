module Mutations
  class LoginUser < Mutations::BaseMutation
    description "Create a vote from a user to verse"

    argument :user_sub, String, required: true
    argument :name, String, required: true
    argument :email, String, required: true
    argument :image, String, required: true

    type Types::UserType

    def resolve(args)
      user = User.find_or_create_by(email: args[:email])
      user.name = args[:name]
      user.image = args[:image]
      user.user_sub = args[:user_sub]
      user.save
      user
    end
  end
end