require 'rails_helper'

describe 'Upload endpoint' do
  before :each do
    AWSResponse = Struct.new(:etag)
    mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")
    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).with(:bucket, :key, :body).and_return(mock_response)
  end

  it 'can upload to an aws s3 bucket' do
    form_body = { audio: 'somefilethatsgoingtobereallylongwhyareyoustillreadingthis' }

    post '/upload', params: form_body, headers: { "Content-Type": 'multipart/form-data' }

    expect(response).to be_successful
  end
end
