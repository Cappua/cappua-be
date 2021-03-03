class CompetitionFacade
  def self.create_competition(competition_params, audio)
    key = "competitions/#{audio.original_filename}"
    response = UploadService.upload_audio(audio, key)
    if successful_upload?(response)
      competition = Competition.create(
        competition_params.merge({track_path: "/#{key}"})
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
