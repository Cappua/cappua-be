module Mutations
  class UpdateCompImage < Mutations::BaseMutation
    description "Add an image to a competition for album artwork"

    argument :id, ID, required: true
    argument :image, String, required: true

    type Types::CompetitionType

    def resolve(args)
      comp = Competition.find(args[:id])
      comp.update(image: args[:image])
      comp
    end
  end
end