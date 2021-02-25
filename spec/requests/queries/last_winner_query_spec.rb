require 'rails_helper'

describe "A graphql query to find last month's winner" do
  it 'can graphql' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    competition = create(:competition, month: 1)
    verse1 = create(:verse, user_id: user1.id, competition_id: competition.id)
    verse2 = create(:verse, user_id: user2.id, competition_id: competition.id)
    verse3 = create(:verse, user_id: user3.id, competition_id: competition.id)
    vote1 = Vote.create(verse_id: verse2.id, user_id: user1.id)
    vote2 = Vote.create(verse_id: verse3.id, user_id: user1.id)
    vote3 = Vote.create(verse_id: verse3.id, user_id: user2.id)
    vote4 = Vote.create(verse_id: verse1.id, user_id: user3.id)

    query_string = "query { lastWinner {
                      audioPath
                      competition {
                        month
                      }
                      user {
                        name
                        image
                      }
                    }
                  }"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(result).to have_key(:data)
    expect(result[:data]).to have_key(:lastWinner)

    last_winner = result[:data][:lastWinner]
    expect(last_winner).to have_key(:audioPath)
    expect(last_winner[:audioPath]).to eq(verse3.audio_path)
    expect(last_winner).to have_key(:competition)
    expect(last_winner[:competition]).to have_key(:month)
    expect(last_winner[:competition][:month]).to eq(1)
    expect(last_winner).to have_key(:user)
    expect(last_winner[:user]).to have_key(:name)
    expect(last_winner[:user][:name]).to eq(user3.name)
    expect(last_winner[:user]).to have_key(:image)
    expect(last_winner[:user][:image]).to eq(user3.image)
  end
end
