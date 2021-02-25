require 'rails_helper'

describe 'It can get all competitions' do
  it 'through graphql' do
    competition1 = create(:competition)
    competition2 = create(:competition)
    competition3 = create(:competition)
    verses = create_list(:verse, 2, competition: competition1)
    query_string = "query {
                      competitions {
                        id
                        trackPath
                        month
                        year
                        description
                        genre
                        rules
                        image
                        verses { id }
                      }
                    }"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(response).to be_successful

    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    expect(result[:data]).to have_key(:competitions)
    expect(result[:data][:competitions]).to be_an(Array)

    competitions = result[:data][:competitions]
    competitions.each do |comp_data|
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
      expect(comp_data).to have_key(:verses)
      expect(comp_data[:verses]).to be_an(Array)
    end 
  end
end
