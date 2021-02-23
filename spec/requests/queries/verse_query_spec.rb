require 'rails_helper'

describe 'A graphql query to get a single verse' do
  it 'can get a successful response with all fields' do
    verse = create(:verse)

    query_string = "query {
      verse(id: #{verse.id}) {
        id
        audioPath
        competitionId
        userId
        title
      }
    }"

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:verse)
    expect(result[:data][:verse]).to have_key(:id)
    expect(result[:data][:verse][:id]).to eq("#{verse.id}")
    expect(result[:data][:verse]).to have_key(:audioPath)
    expect(result[:data][:verse][:audioPath]).to eq(verse.audio_path)
    expect(result[:data][:verse]).to have_key(:competitionId)
    expect(result[:data][:verse][:competitionId]).to eq(verse.competition_id)
    expect(result[:data][:verse]).to have_key(:userId)
    expect(result[:data][:verse][:userId]).to eq(verse.user_id)
    expect(result[:data][:verse]).to have_key(:title)
    expect(result[:data][:verse][:title]).to eq(verse.title)
  end
end

describe 'A graphql query to get multiple verses' do
  it 'returns an array of verses' do
    create_list(:verse, 4)

    query_string = "query {
      verses {
        id
        audioPath
        competitionId
        userId
        title
      }
    }"

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:verses)
    expect(result[:data][:verses].length).to eq(4)
    result[:data][:verses].each do |verse|
      expect(verse).to have_key(:id)
      expect(verse).to have_key(:audioPath)
      expect(verse).to have_key(:competitionId)
      expect(verse).to have_key(:userId)
      expect(verse).to have_key(:title)
    end
  end
end

describe 'Vote info subqueries' do
  before :each do
    @user = create(:user)
    @verse = create(:verse, user: @user)
  end

  it 'upvoted returns false if associated vote does not exist' do
    query_string = "query {
      verse(id: #{@verse.id}) {
        id
        upvoted(userId: #{@user.id})
      }
    }"

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:verse)
    expect(result[:data][:verse]).to have_key(:id)
    expect(result[:data][:verse][:id]).to eq("#{@verse.id}")
    expect(result[:data][:verse]).to have_key(:upvoted)
    expect(result[:data][:verse][:upvoted]).to eq(false)
  end

  it 'upvoted returns true if associated vote does exist' do
    vote = create(:vote, user: @user, verse: @verse)

    query_string = "query {
      verse(id: #{@verse.id}) {
        id
        upvoted(userId: #{@user.id})
      }
    }"

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:verse)
    expect(result[:data][:verse]).to have_key(:id)
    expect(result[:data][:verse][:id]).to eq("#{@verse.id}")
    expect(result[:data][:verse]).to have_key(:upvoted)
    expect(result[:data][:verse][:upvoted]).to eq(true)
  end

  it 'vote count returns number of associated votes' do
    create_list(:vote, 6, verse: @verse)

    query_string = "query {
      verse(id: #{@verse.id}) {
        id
        voteCount
      }
    }"

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:verse)
    expect(result[:data][:verse]).to have_key(:id)
    expect(result[:data][:verse][:id]).to eq("#{@verse.id}")
    expect(result[:data][:verse]).to have_key(:voteCount)
    expect(result[:data][:verse][:voteCount]).to eq(6)
  end
end
