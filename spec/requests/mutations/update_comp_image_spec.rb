require 'rails_helper'

describe 'It can mutate a competition' do
  it 'competition image update' do
    competition = create(:competition)

    query_string = "mutation {updateCompImage(input: 
              {id: #{competition.id}, image: \"https://upload.wikimedia.org/wikipedia/en/7/70/Graduation_%28album%29.jpg\" }) {
                    id
                    image
                    }}"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    
    expect(result).to have_key(:data)
    expect(result[:data]).to be_a(Hash)
    
    expect(result[:data]).to have_key(:updateCompImage)
    expect(result[:data][:updateCompImage]).to be_a(Hash)

    comp_info = result[:data][:updateCompImage]
    expect(comp_info).to have_key(:id)
    expect(comp_info[:id]).to be_a(String)

    expect(comp_info).to have_key(:image)
    expect(comp_info[:image]).to be_a(String)
  end
end 