class VerseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :audio_path, :track_id, :user_id, :title
end
