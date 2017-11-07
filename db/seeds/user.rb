require 'faker'

20.times do
     User.create(
        name: Faker::HarryPotter.unique.character,
        email: Faker::Internet.email(Faker::HarryPotter.unique.character),
        password: Faker::Internet.password
      )
end
