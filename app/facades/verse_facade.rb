class VerseFacade
  def self.create_verse(verse_params, audio)
    key = "verses/#{self.current_year}/#{self.current_month}/#{audio.original_filename}"
    response = UploadService.upload_audio(audio, key)
    if successful_upload?(response)
      verse = Verse.create(
        verse_params.merge({audio_path: key})
      )
    else
      output = Hash.new
      output[:error] = 'Verse could not be successfully uploaded to cloud database.'
      output
    end
  end

  def self.successful_upload?(response)
    response.etag
  end

  def self.current_month
    Date.today.strftime('%m')
  end

  def self.current_year
    Date.today.strftime('%Y')
  end
end
