require 'rails_helper'

describe 'It can mutate a user' do
  it 'user login and creation' do

    query_string = "mutation {
      loginUser (input: {  
        userSub: \"auth0|603abc00b8cdf600708807ad\"
        name: \"cooper.terrones\"
        email: \"cooper.terrones@outlook.com\"
        image: \"https://s.gravatar.com/avatar/646d13a1641492a403c5b81ebb107f0e?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fco.png\" 
    }) {
          userSub
          id
          name
          email
          image
    }
  }"
  post graphql_path, params: { query: query_string }
  result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    
    expect(result[:data]).to have_key(:loginUser)
    expect(result[:data][:loginUser]).to be_a(Hash)

    user_info = result[:data][:loginUser]
    expect(user_info).to have_key(:id)
    expect(user_info[:id]).to be_a(String)

    expect(user_info).to have_key(:userSub)
    expect(user_info[:userSub]).to be_a(String)

    expect(user_info).to have_key(:name)
    expect(user_info[:name]).to be_a(String)

    expect(user_info).to have_key(:email)
    expect(user_info[:email]).to be_a(String)

    expect(user_info).to have_key(:image)
    expect(user_info[:image]).to be_a(String)
  end
  it 'user login if already created' do

    user = create(:user, email: '123@test.com')

    query_string = "mutation {
      loginUser (input: {  
          userSub: \"#{user.user_sub}\"
          name: \"#{user.name}\"
          email: \"#{user.email}\"
          image: \"#{user.image}\" 
      }) {
            userSub
            id
            name
            email
            image
    }
  }"
  post graphql_path, params: { query: query_string }
  result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    
    expect(result[:data]).to have_key(:loginUser)
    expect(result[:data][:loginUser]).to be_a(Hash)

    user_info = result[:data][:loginUser]
    expect(user_info).to have_key(:id)
    expect(user_info[:id]).to eq(user.id.to_s)

    expect(user_info).to have_key(:userSub)
    expect(user_info[:userSub]).to eq(user.user_sub)

    expect(user_info).to have_key(:name)
    expect(user_info[:name]).to eq(user.name)

    expect(user_info).to have_key(:email)
    expect(user_info[:email]).to eq(user.email)

    expect(user_info).to have_key(:image)
    expect(user_info[:image]).to eq(user.image)
  end
end 