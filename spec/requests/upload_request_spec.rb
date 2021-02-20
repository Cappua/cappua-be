require 'rails_helper'

describe 'Upload endpoint' do
  before :each do
    AWSResponse = Struct.new(:etag)
    mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).with(:bucket, :key, :body).and_return(mock_response)
  end

  it 'can upload to an aws s3 bucket' do
    user = create(:user)
    track = create(:track)
    form_body = { 
      audio: 'somefilethatsgoingtobereallylongwhyareyoustillreadingthis',
      userId: user.id ,
      trackId: track.id
    }

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
