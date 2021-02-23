module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :competition, Types::CompetitionType, null: false do
      argument :id, ID, required: true
    end

    def competition(id:)
      Competition.find(id)
    end

    field :verse, Types::VerseType, null: false do
      argument :id, ID, required: true
    end

    def verse(id:)
      Verse.find(id)
    end

    field :verses, [Types::VerseType], null: false 

    def verses
      Verse.all
    end
  end
end
