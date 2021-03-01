require 'rails_helper'

describe 'verse facade' do
  AWSResponse = Struct.new(:etag)
  before :each do
    @audio = fixture_file_upload("spec/fixtures/es_zone_in.mp3")
    allow(Date).to receive(:today).and_return(Date.new(2021,3,1))
  end

  it 'successful upload serializes verse' do
    mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
    include ActionDispatch::TestProcess::FixtureFile

    user = create(:user)
    competition = create(:competition)

    verse_params = {
      user_id: user.id,
      competition_id: competition.id,
      title: 'Just a Friend'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    verse = VerseFacade.create_verse(verse_params, @audio)

    expect(verse).to be_a(Verse)
    expect(verse.id).to be_a(Integer)
    expect(verse.audio_path).to eq("/verses/2021/03/es_zone_in.mp3")
    expect(verse.user_id).to eq(user.id)
    expect(verse.competition_id).to eq(competition.id)
    expect(verse.title).to eq('Just a Friend')
  end

  it 'unsuccessful upload creates error hash key' do
    mock_response = AWSResponse.new(nil)
    include ActionDispatch::TestProcess::FixtureFile

    user = create(:user)
    competition = create(:competition)

    verse_params = {
      user_id: user.id,
      competition_id: competition.id,
      title: 'Just a Friend'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    output = VerseFacade.create_verse(verse_params, @audio)

    expect(output).to be_a(Hash)
    expect(output).to have_key(:error)
    expect(output[:error]).to eq('Verse could not be successfully uploaded to cloud database.')
  end

  it 'current_month' do
    expect(VerseFacade.current_month).to eq('03')
  end

  it 'current_year' do
    expect(VerseFacade.current_year).to eq('2021')
  end
end
