require 'rails_helper'

describe 'Upload endpoint' do # intentionally omitting vcr; see below
  before :each do
    AWSResponse = Struct.new(:etag)
    @mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
    include ActionDispatch::TestProcess::FixtureFile
    @sample_verse = fixture_file_upload("spec/fixtures/es_zone_in.mp3")
    # @sample_verse = File.read('spec/fixtures/es_zone_in.mp3')
  end

  it 'can upload a verse to an aws s3 bucket' do
    user = create(:user)
    track = create(:track)
    form_body = {
      audio: @sample_verse,
      userId: user.id ,
      trackId: track.id,
      type: 'verse'
    }

    # TODO: modify the arguments in the .with statement to match what we're
    # using in the actual controller, or this mock will fail
    # ALSO WARNING: I'm not setting up vcr for this test because I don't want to record
    # the response from AWS; it may contain sensitive data
    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(@mock_response)

    # with({
    #   bucket: 'cappuatracks',
    #   key: 'verses/es_zone_in.mp3',
    #   body: form_body[:audio]
    # }).

    post '/api/v1/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }
    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to be_a(String)
    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to be_a(String)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:audio_path)
    expect(json[:data][:attributes][:audio_path]).to be_a(String)
    expect(json[:data][:attributes]).to have_key(:track_id)
    expect(json[:data][:attributes][:track_id]).to eq(track.id)
    expect(json[:data][:attributes]).to have_key(:user_id)
    expect(json[:data][:attributes][:user_id]).to eq(user.id)
  end
end
