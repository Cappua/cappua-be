# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create users
user = User.find_or_create_by(email: 'justafriend@example.com') do |user|
  user.name = 'Biz Markie'
  user.email = 'justafriend@example.com'
  user.user_sub = "mock_sub"
  user.image = 'https://i.imgur.com/2kXMspT.png'
end

images = [
  'https://i.imgur.com/bXzahL4.png',
  'https://i.imgur.com/43O8jt3.png',
  'https://i.imgur.com/3bbl9nq.png',
  'https://i.imgur.com/Qgoe8N9.png',
  'https://i.imgur.com/9mqoPyi.png',
  'https://i.imgur.com/EOTLeSI.png',
  'https://i.imgur.com/edJqLWX.png',
  'https://i.imgur.com/mamKVDX.png',
  'https://i.imgur.com/824CUyd.png',
  'https://i.imgur.com/PVm5UTW.png']

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
  track_path: '/competitions/march_wu_tang_forever_instrumental_verse.mp3',
  month: 3,
  year: 2021,
  description: "Wu Tang Sword Style. Get with your sick tight click, and go all out.",
  genre: 'East Coast Hip Hop',
  rules: 'Verse submissions are due by March 14th. Final vote tally and winner announcement on April 1st. Rappers can edit the track, but must stay within 16 bars plus intro/outro.',
  image: 'https://i.ytimg.com/vi/5CzsXvAZ6R4/mqdefault.jpg',
  title: 'Wu Tang Forever'
)

9.times do |index|
  word = Faker::Hipster.words[0].capitalize
  word_2 = Faker::Hipster.words[1].capitalize
  Verse.create(
    audio_path: "/verses/2021/03/verse_#{index}.mp3",
    user_id: (index + 2),
    title: "#{word} #{word_2}",
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

# Create March competition, verses, votes
feb_competition = Competition.create(
  track_path: '/competitions/feb_run_the_jewels_out_of_sight.mp3',
  month: 2,
  year: 2021,
  description: "RUN THEM JEWELS FAST. Make Killer Mike and El-P proud with your verses.",
  genre: 'East Coast Hip Hop',
  rules: 'Verse submissions are due by February 14th. Final vote tally and winner announcement on March 1st. Rappers can edit the track, but must stay within 16 bars plus intro/ outro.',
  image: 'https://cdn.vox-cdn.com/thumbor/JOFn2f6bZY2EsUmyxF1GrxGSXjw=/0x0:1548x1024/1200x800/filters:focal(627x76:873x322)/cdn.vox-cdn.com/uploads/chorus_image/image/66314789/run_the_jewels_march_2017_billboard_1548.0.jpg',
  title: 'out of sight'
)

def zero_to_three(number)
  until 0 <= number && number < 3
    number -= 3
  end
  number
end

9.times do |index|
  word = Faker::Hipster.words[0].capitalize
  word_2 = Faker::Hipster.words[1].capitalize
  Verse.create(
    audio_path: "/verses/2021/02/verse_#{zero_to_three(index)}.mp3",
    user_id: (index + 2),
    title: "#{word} #{word_2}",
    competition: feb_competition
  )
end

9.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: (index + 10)
  )
end

3.times do |index|
  Vote.create(
    user_id: (index + 2),
    verse_id: 16
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
  verse_id: 18
)

# Create January competition, verses, votes
jan_competition = Competition.create(
  track_path: '/competitions/jan_whats_dat_money.mp3',
  month: 1,
  year: 2021,
  description: "G-Funk/Trap Hybrid. Gladiators, welcome to 2021. Let's kick this year off with a 32 bar track featuring our in-house DJ Tedi Kruise.",
  genre: 'G Funk Trap Hybrid',
  rules: 'Verse submissions are due by January 14th. Final vote tally and winner announcement on February 1st. Rappers cannot edit the track, but have a total of 32 bars and intro/outro to work with.',
  image: 'https://static.billboard.com/files/media/Lil-Dicky-2016-billboard-1548-compressed.jpg',
  title: "What's Dat Money"
)

def zero_to_four(number)
  until 0 <= number && number < 4
    number -= 4
  end
  number
end

9.times do |index|
  word = Faker::Hipster.words[0].capitalize
  word_2 = Faker::Hipster.words[1].capitalize
  Verse.create(
    audio_path: "/verses/2021/01/verse_#{zero_to_four(index)}.mp3",
    user_id: (index + 2),
    title: "#{word} #{word_2}",
    competition: jan_competition
  )
end

9.times do |index|
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
