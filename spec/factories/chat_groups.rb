require 'faker'

FactoryBot.define do

  factory :chat_group do
    name                     { Faker::HarryPotter.location }
  end

end
