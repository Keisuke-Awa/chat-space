require 'faker'

FactoryBot.define do

  factory :message do
    association :user,       factory: :user
    association :chat_group, factory: :chat_group
    body              { Faker::HarryPotter.quote }
    image             { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/ringo.jpg')) }
  end

end
