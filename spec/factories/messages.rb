# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  body          :text(65535)
#  image         :string(255)      default("")
#  user_id       :integer
#  chat_group_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'faker'

FactoryBot.define do

  factory :message do
    association :user,       factory: :user
    association :chat_group, factory: :chat_group
    body              { Faker::HarryPotter.quote }
    image             { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/ringo.jpg')) }
  end

end
