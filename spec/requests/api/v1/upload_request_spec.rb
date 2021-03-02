require 'rails_helper'
require 'date'

describe 'Upload endpoint' do # intentionally omitting vcr; see below
  AWSResponse = Struct.new(:etag)
  before :each do
    @mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
    include ActionDispatch::TestProcess::FixtureFile
    @sample_verse = fixture_file_upload("spec/fixtures/es_zone_in.mp3")
  end

  it 'can upload a verse to an aws s3 bucket' do
    user = create(:user)
    competition = create(:competition)
    form_body = {
      audio: @sample_verse,
      user_id: user.id,
      competition_id: competition.id,
      title: 'Just a Friend',
      type: 'verse'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('verse')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:audio_path)
    expect(json[:data][:attributes][:audio_path]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:competition_id)
    expect(json[:data][:attributes][:competition_id]).to eq(competition.id)
    expect(json[:data][:attributes]).to have_key(:user_id)
    expect(json[:data][:attributes][:user_id]).to eq(user.id)
    expect(json[:data][:attributes]).to have_key(:title)
    expect(json[:data][:attributes][:title]).to eq('Just a Friend')
  end

  it 'can upload a competition to an aws s3 bucket' do
    form_body = {
      audio: @sample_verse,
      month: 2,
      year: 2021,
      type: 'competition',
      description: "Wu Tang Sword Style",
      genre: "East Coast Hip Hop",
      rules: "Don't talk about Wu Tang Sword Style",
      image: 'https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg',
      title: 'Wu Tang Forever'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('competition')
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:track_path)
    expect(json[:data][:attributes][:track_path]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:month)
    expect(json[:data][:attributes][:month]).to eq(form_body[:month])
    expect(json[:data][:attributes]).to have_key(:year)
    expect(json[:data][:attributes][:year]).to eq(form_body[:year])
    expect(json[:data][:attributes]).to have_key(:description)
    expect(json[:data][:attributes][:description]).to eq(form_body[:description])
    expect(json[:data][:attributes]).to have_key(:genre)
    expect(json[:data][:attributes][:genre]).to eq(form_body[:genre])
    expect(json[:data][:attributes]).to have_key(:rules)
    expect(json[:data][:attributes][:rules]).to eq(form_body[:rules])
    expect(json[:data][:attributes]).to have_key(:image)
    expect(json[:data][:attributes][:image]).to eq(form_body[:image])
    expect(json[:data][:attributes]).to have_key(:title)
    expect(json[:data][:attributes][:title]).to eq(form_body[:title])
  end

  it 'sends 400 response for verse upload requests with bad user/tracks ids' do
    form_body = {
      audio: @sample_verse,
      user_id: 1,
      competition_id: 1,
      type: 'verse'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Invalid user or competition id.')
  end

  it 'sends 500 response for verse upload requests that do not successfully upload' do
    user = create(:user)
    competition = create(:competition)
    form_body = {
      audio: @sample_verse,
      user_id: user.id,
      competition_id: competition.id,
      type: 'verse'
    }
    mock_response = AWSResponse.new(nil)

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(500)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Verse could not be successfully uploaded to cloud database.')
  end

  it 'sends 400 response for competition track upload requests with invalid month' do
    form_body = {
      audio: @sample_verse,
      month: 15,
      year: 2021,
      type: 'competition'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Month and year must be included and valid in competition upload requests.')
  end

  it 'sends 400 response for competition track upload requests with no year parameter' do
    form_body = {
      audio: @sample_verse,
      month: 10,
      year: nil,
      type: 'competition'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Month and year must be included and valid in competition upload requests.')
  end

  it 'sends 400 response for competition track upload requests with no month parameter' do
    form_body = {
      audio: @sample_verse,
      month: nil,
      year: 2021,
      type: 'competition'
    }

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Month and year must be included and valid in competition upload requests.')
  end

  it 'sends 500 response for competition track upload requests that do not successfully upload' do
    form_body = {
      audio: @sample_verse,
      month: 2,
      year: 2021,
      type: 'competition'
    }

    mock_response = AWSResponse.new(nil)

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(500)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Competition could not be successfully uploaded to cloud database.')
  end

  it 'sends 400 response for upload requests with an invalid type' do
    form_body = {
      audio: @sample_verse,
      month: 2,
      year: 2021,
      type: 'jamboree'
    }

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(json).to be_a(Hash)
    expect(json[:error]).to eq('Invalid type.')
  end
end
