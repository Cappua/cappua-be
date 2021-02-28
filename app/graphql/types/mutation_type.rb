module Types
  class MutationType < Types::BaseObject
    field :create_vote, mutation: Mutations::CreateVote 
    field :delete_vote, mutation: Mutations::DeleteVote 
    field :update_comp_image, mutation: Mutations::UpdateCompImage
    field :login_user, mutation: Mutations::LoginUser
  end
end
