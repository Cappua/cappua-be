# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
user = User.create(
  name: 'Biz Markie',
  email: 'justafriend@example.com',
  user_sub: "mock_sub",
  image: 'https://media2.fdncms.com/riverfronttimes/imager/u/slideshow/2654166/bizmarkie.jpg'
)

images = [
  'https://media.gq.com/photos/5594122baf57fbd15c06a6cb/4:3/w_800%2Ch_600%2Cc_limit/mark-zuckerberg-facebook.jpg',
  'https://pbs.twimg.com/profile_images/1237550450/mstom_400x400.jpg',
  'https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fblogs-images.forbes.com%2Fjeffkauflin%2Ffiles%2F2018%2F02%2FWinklevoss-twins-1200x852.jpg',
  'https://i.insider.com/5b9235bb5c5e5254548b59f5?width=1136&format=jpeg',
  'https://specials-images.forbesimg.com/imageserve/5f469ea85cc82fc8d6083f05/960x0.jpg?fit=scale',
  'https://i0.wp.com/www.eatthis.com/wp-content/uploads/2021/01/anthony-fauci.jpg?resize=640%2C360&ssl=1',
  'https://i1.sndcdn.com/artworks-000459154392-qch8fs-t500x500.jpg',
  'data:image/jpeg;base64,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',
  'https://cdn.cnn.com/cnnnext/dam/assets/161010014201-clinton-trump-debate-st-louis-ken-bone-sot-00000411-super-169.jpg',
  'https://f4zu.files.wordpress.com/2013/05/antoine_dodson1.jpg?w=620']

10.times do |index|
  User.create(
    name: Faker::Cannabis.strain,
    email: Faker::Internet.email,
    user_sub: "mosk_sub",
    image: images[index]
  )
end

# Create March competition, verses, votes
march_competition = Competition.create(
  track_path: '/competitions/march_wu_tang_forever.mp3',
  month: 3,
  year: 2021,
  description: "This month's theme is East Coast Hip Hop. Bring your Wu Tang style to this one.",
  genre: 'East Coast Hip Hop',
  rules: 'Verse submissions are due by March 14th. Final vote tally and winner announcement on March 31st. Rappers can edit track, but most stay within 16 bars.',
  image: 'https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg'
)

10.times do |index|
  word = Faker::Hipster.words[0].capitalize
  word_2 = Faker::Hipster.words[1].capitalize
  Verse.create(
    audio_path: "/verses/2021/03/verse_#{index}.mp3",
    user_id: (index + 2),
    title: "#{word} #{word_2}",
    competition: march_competition
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

# Create March competition, verses, votes
feb_competition = Competition.create(
  track_path: '/competitions/feb_some_comp.mp3',
  month: 2,
  year: 2021,
  description: "This month's theme is East Coast Hip Hop. Bring your Wu Tang style to this one.",
  genre: 'East Coast Hip Hop',
  rules: 'Verse submissions are due by March 14th. Final vote tally and winner announcement on March 31st. Rappers can edit track, but most stay within 16 bars.',
  image: 'https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg'
)

10.times do |index|
  word = Faker::Hipster.words[0].capitalize
  word_2 = Faker::Hipster.words[1].capitalize
  Verse.create(
    audio_path: "/verses/2021/03/verse_#{index}.mp3",
    user_id: (index + 2),
    title: "#{word} #{word_2}",
    competition: feb_competition
  )
end

10.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: (index + 10)
  )
end

3.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 18
  )
end

2.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 17
  )
end

Vote.create(
  user: user,
  verse_id: 16
)

# Create January competition, verses, votes
jan_competition = Competition.create(
  track_path: '/competitions/jan_some_comp.mp3',
  month: 1,
  year: 2021,
  description: "This month's theme is East Coast Hip Hop. Bring your Wu Tang style to this one.",
  genre: 'East Coast Hip Hop',
  rules: 'Verse submissions are due by March 14th. Final vote tally and winner announcement on March 31st. Rappers can edit track, but most stay within 16 bars.',
  image: 'https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg'
)

10.times do |index|
  word = Faker::Hipster.words[0].capitalize
  word_2 = Faker::Hipster.words[1].capitalize
  Verse.create(
    audio_path: "/verses/2021/01/verse_#{index}.mp3",
    user_id: (index + 2),
    title: "#{word} #{word_2}",
    competition: feb_competition
  )
end

10.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: (index + 10)
  )
end

3.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 27
  )
end

2.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 26
  )
end

Vote.create(
  user: user,
  verse_id: 25
)
