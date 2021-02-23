require 'rails_helper'

describe 'It can mutate a vote' do
  it 'vote creation' do
    user = create(:user)
    verse = create(:verse)
    query_string = "mutation {createVote(input: {verseId: #{verse.id}, userId: #{user.id}}) {
                    id,
                    verseId,
                    userId
                    }}"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    
    expect(result[:data]).to have_key(:createVote)
    expect(result[:data][:createVote]).to be_a(Hash)

    vote_info = result[:data][:createVote]
    expect(vote_info).to have_key(:id)
    expect(vote_info[:id]).to be_a(String)

    expect(vote_info).to have_key(:verseId)
    expect(vote_info[:verseId]).to be_a(Numeric)

    expect(vote_info).to have_key(:userId)
    expect(vote_info[:userId]).to be_a(Numeric)
  end
  it 'vote deletion' do
    user = create(:user)
    verse = create(:verse)
    vote = Vote.create(user_id: user.id, verse_id: verse.id)

    query_string = "mutation {
      deleteVote(input: {
        id: #{vote.id}
      }) {
        id
      }
    }"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    
    expect(result[:data]).to have_key(:deleteVote)
    expect(result[:data][:deleteVote]).to be_a(Hash)
    
    expect(result[:data][:deleteVote]).to have_key(:id)
    expect(result[:data][:deleteVote][:id]).to be_a(String)
  end
end 