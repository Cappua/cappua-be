module Mutations
  class DeleteVote < Mutations::BaseMutation
    description "Delete a vote from a user to verse"

    argument :id, ID, required: true

    type Types::VoteType

    def resolve(args)
      vote = Vote.find(args[:id])
      vote.destroy
      vote
    end
  end
end