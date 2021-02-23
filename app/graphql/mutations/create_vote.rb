module Mutations
  class CreateVote < Mutations::BaseMutation
    description "Create a vote from a user to verse"

    argument :verse_id, Integer, required: true
    argument :user_id, Integer, required: true

    type Types::VoteType

    def resolve(args)
      user = User.find(args[:user_id])
      verse = Verse.find(args[:verse_id])

      vote = Vote.create(
        user_id: user.id,
        verse_id: verse.id
      )
    end
  end
end