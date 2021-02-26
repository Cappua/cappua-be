class VerseFacade
  def self.create_verse(verse_params, audio)
    key = "verses/#{audio.original_filename}"
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
end
