class TrackSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :track_path, :month, :year
end
