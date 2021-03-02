require 'rails_helper'

describe "A graphql query to find this month's top three contenders" do
  it 'can graphql' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    competition = create(:competition, month: Time.now.month )
    verse1 = create(:verse, user_id: user1.id, competition_id: competition.id)
    verse2 = create(:verse, user_id: user2.id, competition_id: competition.id)
    verse3 = create(:verse, user_id: user3.id, competition_id: competition.id)
    vote1 = Vote.create(verse_id: verse2.id, user_id: user1.id)
    vote2 = Vote.create(verse_id: verse3.id, user_id: user1.id)
    vote3 = Vote.create(verse_id: verse3.id, user_id: user2.id)
    vote4 = Vote.create(verse_id: verse1.id, user_id: user2.id)
    vote5 = Vote.create(verse_id: verse3.id, user_id: user3.id)
    vote6 = Vote.create(verse_id: verse1.id, user_id: user3.id)

    query_string = "query { topThreeContenders {
                      audioPath
                      title
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
    expect(result[:data]).to have_key(:topThreeContenders)

    top_three = result[:data][:topThreeContenders]
    expect(top_three).to be_an(Array)
    expect(top_three[0]).to have_key(:audioPath)
    expect(top_three[0][:audioPath]).to eq(verse3.audio_path)
    expect(top_three[0]).to have_key(:title)
    expect(top_three[0][:title]).to eq(verse3.title)
    expect(top_three[0]).to have_key(:user)
    expect(top_three[0][:user]).to be_a(Hash)
    expect(top_three[0][:user]).to have_key(:name).and have_key(:image)
    expect(top_three[0][:user][:name]).to eq(verse3.user.name)
    expect(top_three[0][:user][:image]).to eq(verse3.user.image)

    expect(top_three[2][:audioPath]).to eq(verse2.audio_path)
    expect(top_three[2][:title]).to eq(verse2.title)
    expect(top_three[2][:user][:name]).to eq(verse2.user.name)
    expect(top_three[2][:user][:image]).to eq(verse2.user.image)
  end
end
