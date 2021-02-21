require 'rails_helper'

describe 'Upload endpoint' do # intentionally omitting vcr; see below
  before :each do
    AWSResponse = Struct.new(:etag)
    @mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
  end

  it 'can upload to an aws s3 bucket' do
    user = create(:user)
    track = create(:track)
    form_body = { 
      audio: 'somefilethatsgoingtobereallylongwhyareyoustillreadingthis',
      userId: user.id ,
      trackId: track.id
    }

    # TODO: modify the arguments in the .with statement to match what we're 
    # using in the actual controller, or this mock will fail
    # ALSO WARNING: I'm not setting up vcr for this test because I don't want to record
    # the response from AWS; it may contain sensitive data
    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).with({
      bucket: 'some_bucket',
      key: 'file_prefix',
      body: form_body[:audio]
    }).and_return(@mock_response)

    post '/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }

    expect(response).to be_successful
    expect(response.body).to have_key(:data)
    expect(response.body[:data]).to have_key(:verse)
    expect(response.body[:data][:verse]).to have_key(:audio_path)
    expect(response.body[:data][:verse][:audio_path]).to be_a(String)
    expect(response.body[:data][:verse]).to have_key(:track_id)
    expect(response.body[:data][:verse][:track_id]).to eq(track.id)
    expect(response.body[:data][:verse]).to have_key(:user_id)
    expect(response.body[:data][:verse][:user_id]).to eq(user.id)
  end
end
