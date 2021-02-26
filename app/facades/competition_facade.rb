class CompetitionFacade
  def self.create_competition(competition_params, audio)
    key = "competitions/#{audio.original_filename}"
    response = UploadService.upload_audio(audio, key)
    if successful_upload?(response)
      competition = Competition.create(
        track_path: key,
        month: competition_params[:month],
        year: competition_params[:year],
        description: competition_params[:description],
        genre: competition_params[:genre],
        rules: competition_params[:rules],
        image: competition_params[:image]
      )
    else
      output = Hash.new
      output[:error] = 'Competition could not be successfully uploaded to cloud database.'
      output
    end
  end

  def self.successful_upload?(response)
    response.etag
  end
end
