class Api::V1::UploadController < ApplicationController
  def create
    s3 = Aws::S3::Client.new(
      region: 'us-west-1',
      access_key_id: ENV["AWS_ACCESS_KEY_ID"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    )

    if valid_verse?
      key = "verses/#{params[:audio].original_filename}"
      response = s3.put_object(bucket: ENV['S3_BUCKET'], key: key, body: params[:audio])

      if response.etag
        verse = Verse.create(
          audio_path: key,
          title: params[:title],
          user_id: params[:userId],
          track_id: params[:trackId]
        )

        output = VerseSerializer.new(verse)

        render json: output
      else
        output = Hash.new
        output[:error] = 'Verse could not be successfully uploaded to cloud database.'

        render json: output, :status => 500
      end
    elsif invalid_verse?
      output = Hash.new
      output[:error] = 'Invalid user or track id.'
      render json: output, :status => 400
    elsif valid_track?
      key = "tracks/#{params[:audio].original_filename}"
      response = s3.put_object(bucket: ENV['S3_BUCKET'], key: key, body: params[:audio])

      if response.etag
        track = Track.create(
          track_path: key,
          month: params[:month],
          year: params[:year]
        )
        output = TrackSerializer.new(track)

        render json: output
      else
        output = Hash.new
        output[:error] = 'Track could not be successfully uploaded to cloud database.'

        render json: output, :status => 500
      end
    elsif invalid_track?
      output = Hash.new
      output[:error] = 'Month and year must be included and valid in track upload requests.'
      render json: output, :status => 400
    else
      output = Hash.new
      output[:error] = 'Invalid type.'

      render json: output, :status => 400
    end
  end

  def valid_ids?
    user = User.where(id: params[:userId])
    track = Track.where(id: params[:trackId])
    user != [] && track != []
  end

  def valid_verse?
    params[:type] == 'verse' && valid_ids?
  end

  def invalid_verse?
    params[:type] == 'verse'
  end

  def valid_track?
    (1..12).to_a.include?(params[:month].to_i) && params[:year].present? && params[:type] == 'track'  # && user == admin
  end

  def invalid_track?
    params[:type] == 'track'
  end
end
