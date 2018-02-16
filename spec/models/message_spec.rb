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

require 'rails_helper'
describe Message do
  describe '#create' do

    it "is valid with a body, user_id, chat_group_id" do
      message = build(:message, image: "")
      expect(message).to be_valid
    end

    it "is valid with a image, user_id, chat_group_id" do
      message = build(:message, body: "")
      expect(message).to be_valid
    end

    it "is valid with a body, image, user_id, chat_group_id" do
      message = build(:message)
      expect(message).to be_valid
    end

    it "is invalid without a body and image" do
      message = build(:message, body: "", image: "")
      message.valid?
      expect(message.errors[:body_or_image]).to include("を入力してください")
    end

    it "is invalid without an user_id" do
      message = build(:message, user_id: '')
      message.valid?
      expect(message.errors[:user_id]).to include("を入力してください")
    end

    it "is invalid without an user_id is not an integer" do
      message = build(:message, user_id: 'test')
      message.valid?
      expect(message.errors[:user_id]).to include("は数値で入力してください")
    end

    it "is invalid without a chat_group_id" do
      message = build(:message, chat_group_id: '')
      message.valid?
      expect(message.errors[:chat_group_id]).to include("を入力してください")
    end

    it "is invalid without a chat_group_id is not an integer" do
      message = build(:message, chat_group_id: 'test')
      message.valid?
      expect(message.errors[:chat_group_id]).to include("は数値で入力してください")
    end

  end
end
