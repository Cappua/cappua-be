class VerseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :audio_path, :competition_id, :user_id, :title
end
