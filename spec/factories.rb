FactoryBot.define do
  factory :user do
    name { Faker::TvShows::FamilyGuy.character }
    email { Faker::Internet.email }
    image { Faker::Internet.url }
  end

  factory :track do
    track_path { Faker::Internet.url }
    month { rand(13) }
    year { 2021 }
  end

  factory :verse do
    track_id { rand(100) }
    user_id { rand(100) }
    audio_path { Faker::Internet.url }
    user
    track
  end
end
