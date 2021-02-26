require 'rails_helper'

describe 'GraphQL user query' do
  it 'returns a single user by id' do
    user = create(:user)
    query_string = <<-GRAPHQL
      query {
        user(id: #{user.id}) {
          id
          name
          email
          image
          verse {
            id
          }
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key(:data) 
    expect(result[:data]).to have_key(:user) 
    expect(result[:data][:user]).to have_key(:id) 
    expect(result[:data][:user][:id]).to eq(user.id) 
    expect(result[:data][:user]).to have_key(:name) 
    expect(result[:data][:user][:email]).to eq(user.email) 
    expect(result[:data][:user]).to have_key(:image) 
    expect(result[:data][:user][:image]).to eq(user.image) 
    expect(result[:data][:user][:verse]).to have_key(:id) 
  end
end
