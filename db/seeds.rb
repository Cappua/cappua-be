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

competition = Competition.create(
  track_path: '/competitions/nu_metal_jamboree',
  month: 2,
  year: 2021,
  description: 'Fred Durst and Stuff',
  genre: 'Nu Metal Jamboree',
  rules: '4 weeks'
)

10.times do |index|
  User.create(
    name: Faker::Games::Witcher.character,
    email: Faker::Internet.email,
    image: "https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg"
  )
end

10.times do |index|
  Verse.create(
    audio_path: "verses/verse_#{index}",
    user_id: (index + 2),
    title: "verse_#{index}",
    competition: competition
  )
end

10.times do |index|
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
