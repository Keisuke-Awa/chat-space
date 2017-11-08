require 'faker'

6.times do
     Message.create(
        user_id: rand(1..3),
        chat_group_id: rand(1..3),
        body: Faker::HarryPotter.quote
      )
end
