class UploadController < ApplicationController
  def new
    s3 = Aws::S3::Client.new(
      region: 'us-west-1',
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )
    # s3.put_object(bucket: bucket_name, key: file_name, body: params[:audio])
    # key is the locatoin in the bucket where the file will be stored
    # params[:audio] contains the file we want to upload
  end
end
