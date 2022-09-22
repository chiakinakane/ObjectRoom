# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
   email: 'a@a',
   password: 'aaaaaa'
)

User.create!(
   last_name: '盛り盛り',
   first_name: '食べ盛り',
   kana_last_name: 'モリモリ',
   kana_first_name: 'タベザカリ',
   email: 'aa@aa',
   password: 'aaaaaa'
)

Genre.create!(
   name: 'リビング'
)
Genre.create!(
   name: '寝室'
)
Genre.create!(
   name: '台所'
)
