# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Category.create(
  [
    { id: 1, name: 'music' },
  ]
)

MediaType.create(
  [
    { category_id: 1, name: 'piano' },
    { category_id: 1, name: 'guitar' },
    { category_id: 1, name: 'violin' },
    { category_id: 1, name: 'drum' },
    { category_id: 1, name: 'saxophone' },
    { category_id: 1, name: 'thrumpet' },
    { category_id: 1, name: 'flute' },
    { category_id: 1, name: 'other' },
  ]
)

MediaSubType.create(
  [
    { category_id: 1, name: 'classic' },
    { category_id: 1, name: 'pop_rock' },
    { category_id: 1, name: 'jazz' },
    { category_id: 1, name: 'movie' },
    { category_id: 1, name: 'animation' },
    { category_id: 1, name: 'kid' },
    { category_id: 1, name: 'popular' },
    { category_id: 1, name: 'new' },
    { category_id: 1, name: 'other' },
  ]
)
