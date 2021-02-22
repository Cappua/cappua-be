require 'rails_helper'

describe 'It can get a single competition' do
  it 'through graphql' do
    competition = create(:competition)
    query_string = "query {competition(id: #{competition.id}) {
                      id
                      trackPath
                      month
                      year
                      description
                      genre
                      rules
                    }}"

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    expect(result).to eq({
                          'data': {
                            'competition': {
                              'id': "#{competition.id}",
                              'trackPath': "#{competition.track_path}",
                              'month': competition.month,
                              'year': competition.year,
                              'description': "#{competition.description}",
                              'genre': "#{competition.genre}",
                              'rules': "#{competition.rules}"
                            }
                          }
                        })
  end
end