require 'faker'

FactoryBot.define do

  factory :chat_group do
    name                     { Faker::Company.name }
  end

end
