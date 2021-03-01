# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: 'Biz Markie',
  email: 'justafriend@example.com',
  image: 'https://media2.fdncms.com/riverfronttimes/imager/u/slideshow/2654166/bizmarkie.jpg'
)

march_competition = Competition.create(
  track_path: '/competitions/march_wu_tang_forever.mp3',
  month: 3,
  year: 2021,
  description: "This month's theme is East Coast Hip Hop. Bring your Wu Tang style to this one.",
  genre: 'East Coast Hip Hop',
  rules: 'Verse submissions are due by March 14th. Final vote tally and winner announcement on March 31st. Rappers can edit track, but most stay within 16 bars.',
  image: 'https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg',
  verse_instrumental: '/competitions/march_wu_tang_forever_instrumental_verse.mp3'
)

10.times do |index|
  User.create(
    name: Faker::TvShows::TheFreshPrinceOfBelAir.character,
    email: Faker::Internet.email,
    image: "https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg"
  )
end

9.times do |index|
  Verse.create(
    audio_path: "/verses/2021/03/verse_#{index}.mp3",
    user_id: (index + 2),
    title: "verse_#{index}",
    competition: march_competition
  )
end

9.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: (index + 1)
  )
end

3.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 9
  )
end

2.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 8
  )
end

Vote.create(
  user: user,
  verse_id: 7
)
