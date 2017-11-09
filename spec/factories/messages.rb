require 'faker'

FactoryBot.define do

  factory :message do
    user_id           rand(1..3),
    chat_group_id     rand(1..3),
    body              Faker::HarryPotter.quote,
    image             Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/factories/images/ringo.jpg'))
  end

end
