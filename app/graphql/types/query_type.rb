module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end
        
    field :competitions, [Types::CompetitionType], null: false
    
    def competitions
      Competition.all
    end

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

    field :last_winner, Types::LastWinner, null: false

    def last_winner
      Verse.last_month_winner
    end

    field :top_three_contenders, [Types::TopThreeContenders], null: false

    def top_three_contenders
      Verse.top_three
    end

    # last winner winning verse by prior month with most votes.length
  end
end
