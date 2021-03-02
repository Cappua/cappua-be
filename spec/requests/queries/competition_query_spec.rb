require 'rails_helper'

describe 'It can get a single competition' do
  it 'through graphql' do
    competition = create(:competition)
    verses = create_list(:verse, 2, competition: competition)
    query_string = "query {competition(month: #{competition.month}) {
                      id
                      trackPath
                      month
                      year
                      description
                      genre
                      rules
                      image
                      verses { id }
                      title
                    }}"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful

    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    expect(result[:data]).to have_key(:competition)
    expect(result[:data][:competition]).to be_an(Hash)

    comp_data = result[:data][:competition]
    expect(comp_data).to have_key(:id)
    expect(comp_data[:id]).to be_a(String)
    expect(comp_data).to have_key(:trackPath)
    expect(comp_data[:trackPath]).to be_a(String)
    expect(comp_data).to have_key(:month)
    expect(comp_data[:month]).to be_a(Numeric)
    expect(comp_data).to have_key(:year)
    expect(comp_data[:year]).to be_a(Numeric)
    expect(comp_data).to have_key(:description)
    expect(comp_data[:description]).to be_a(String)
    expect(comp_data).to have_key(:genre)
    expect(comp_data[:genre]).to be_a(String)
    expect(comp_data).to have_key(:rules)
    expect(comp_data[:rules]).to be_a(String)
    expect(comp_data).to have_key(:image)
    expect(comp_data[:image]).to eq(competition.image)
    expect(comp_data).to have_key(:verses)
    expect(comp_data[:verses]).to be_an(Array)
    expect(comp_data).to have_key(:title)
    expect(comp_data[:title]).to be_a(String)
  end
end
