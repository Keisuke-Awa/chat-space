# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

20.times do
     User.create(
        name: Faker::HarryPotter.unique.character,
        email: Faker::Internet.email(Faker::HarryPotter.unique.character),
        password: Faker::Internet.password
      )
end

Message.create(user_id: 1, chat_group_id: 1, body:'seedtest!!!')
Message.create(user_id: 1, chat_group_id: 1, body:'seedてすと')
Message.create(user_id: 2, chat_group_id: 1, body:'seedいえええい')
Message.create(user_id: 2, chat_group_id: 1, body:'seddddddd')
Message.create(user_id: 3, chat_group_id: 1, body:'si-do')
Message.create(user_id: 3, chat_group_id: 1, body:'初期作成')
