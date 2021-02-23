FactoryBot.define do
  factory :user do
    name { Faker::TvShows::FamilyGuy.character }
    email { Faker::Internet.email }
    image { Faker::Internet.url }
  end

  factory :competition do
    track_path { Faker::Internet.url }
    month { rand(13) }
    year { 2021 }
    description { Faker::Games::Pokemon.name }
    genre { Faker::Games::Pokemon.move }
    rules { Faker::Games::Pokemon.location }
  end

  factory :verse do
    competition_id { rand(100) }
    user_id { rand(100) }
    audio_path { Faker::Internet.url }
    title { Faker::Games::Witcher.witcher }
    user
    competition
  end
end
