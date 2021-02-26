class UploadService
  def self.upload_audio(audio, key)
    s3.put_object(bucket: ENV['S3_BUCKET'], key: key, body: audio)
  end

  def self.s3
    Aws::S3::Client.new(
      region: 'us-west-1',
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )
  end
end
