require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }


  describe 'GET #index' do
    let!(:chat_groups) { create_list(:chat_group, 5) }
    context "when user signed in" do
      before do
        login_user user
        get :index, params: { chat_group_id: chat_groups.first.id }
      end

      it "assigns the requested chat_group to @chat_group" do
        expect(assigns(:chat_group)).to eq chat_groups.first
      end

      it "assigns the requested messages to @messages" do
        messages = create_list(:message, 5, chat_group: chat_groups.first)
        expect(assigns(:messages)).to eq messages
      end

      it "assigns a new message to @message" do
        expect(assigns(:message)).to be_a_new Message
      end

      it "renders the :index template " do
        expect(response).to render_template :index
      end

    end

    context "when user not signed in" do
      it "redirect to new_user_session_path " do
        get :index, params: { chat_group_id: chat_groups.first.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #create' do
    let!(:chat_group) { create(:chat_group) }
    subject {
      Proc.new { post :create, params: { chat_group_id: chat_group.id, message: message_params } }
    }
    context "when user signed in" do
      before do
        login_user user
      end

      context "with valid message attributes" do
        let(:message_params) { attributes_for(:message) }

        it "assigns the requested chat_group to @chat_group" do
          subject.call
          expect(assigns(:chat_group)).to eq chat_group
        end

        it "creates a new message" do
          expect{
            subject.call
          }.to change(Message, :count).by(1)
        end

        it "redirects to the :index template with flash notice" do
          subject.call
          expect(response).to redirect_to chat_group_messages_path(chat_group)
          expect(flash[:notice]).to be_present
        end
      end

      context "with invalid message attributes" do
        let(:message_params) { attributes_for(:message, body: nil, image: nil) }

        it "assigns the requested chat_group to @chat_group" do
          subject.call
          expect(assigns(:chat_group)).to eq chat_group
        end

        it "cannot create a new message" do
          expect {
            subject.call
          }.to change(Message, :count).by(0)
        end

        it "redirects to the :index template with flash alert" do
          subject.call
          expect(response).to redirect_to chat_group_messages_path(chat_group)
          expect(flash[:alert]).to be_present
        end
      end

    end

    context "when user not signed in" do
      let(:message_params) { attributes_for(:message) }
      it "redirect to new_user_session_path " do
        subject.call
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end
