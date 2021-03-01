require 'rails_helper'

describe 'competition facade' do
  AWSResponse = Struct.new(:etag)
  before :each do
    @audio = fixture_file_upload("spec/fixtures/es_zone_in.mp3")
  end

  it 'successful upload serializes competition' do
    mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
    include ActionDispatch::TestProcess::FixtureFile

    user = create(:user)
    competition = create(:competition)

    competition_params = {
      month: "2",
      year: "2021",
      description: "This month's theme is club bangers.",
      genre: "Club Bangers",
      rules: "Vulcan-Style Deathmatch",
      image: "https://i.ytimg.com/vi/AphxyjrH4SE/hqdefault.jpg"
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    competition = CompetitionFacade.create_competition(competition_params, @audio)

    expect(competition).to be_a(Competition)
    expect(competition.id).to be_a(Integer)
    expect(competition.track_path).to eq("/competitions/es_zone_in.mp3")
    expect(competition.month).to eq(2)
    expect(competition.year).to eq(2021)
    expect(competition.description).to eq("This month's theme is club bangers.")
    expect(competition.genre).to eq("Club Bangers")
    expect(competition.rules).to eq("Vulcan-Style Deathmatch")
    expect(competition.image).to eq("https://i.ytimg.com/vi/AphxyjrH4SE/hqdefault.jpg")
  end

  it 'unsuccessful upload creates error hash key' do
    mock_response = AWSResponse.new(nil)
    include ActionDispatch::TestProcess::FixtureFile

    user = create(:user)
    competition = create(:competition)

    competition_params = {
      month: "2",
      year: "2021",
      description: "This month's theme is club bangers.",
      genre: "Club Bangers",
      rules: "Vulcan-Style Deathmatch",
      image: "https://i.ytimg.com/vi/AphxyjrH4SE/hqdefault.jpg"
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    output = CompetitionFacade.create_competition(competition_params, @audio)

    expect(output).to be_a(Hash)
    expect(output).to have_key(:error)
    expect(output[:error]).to eq('Competition could not be successfully uploaded to cloud database.')
  end
end
