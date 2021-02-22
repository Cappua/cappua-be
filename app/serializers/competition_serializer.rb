class CompetitionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :track_path, :month, :year
end
