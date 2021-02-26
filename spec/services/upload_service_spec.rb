require 'rails_helper'

describe 'upload service' do
  AWSResponse = Struct.new(:etag)
  before :each do
    @audio = fixture_file_upload("spec/fixtures/es_zone_in.mp3")
    @key = "verses/es_zone_in.mp3"
  end

  it 'gets an etag for successfully uploaded audio files' do
    mock_response = AWSResponse.new("\"55e5r7b11rr7575f11l36423298e3a22\"")

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    response = UploadService.upload_audio(@audio, @key)

    expect(response.etag).to eq("\"55e5r7b11rr7575f11l36423298e3a22\"")
  end

  it 'gets an etag of nil for usuccessfully uploaded audio files' do
    mock_response = AWSResponse.new(nil)

    allow_any_instance_of(Aws::S3::Client).to receive(:put_object).and_return(mock_response)

    response = UploadService.upload_audio(@audio, @key)

    expect(response.etag).to eq(nil)
  end
end
