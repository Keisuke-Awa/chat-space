require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }
  let!(:chat_groups) { create_list(:chat_group, 5) }


  describe 'GET #index' do
    context "when user signed in" do
      before do
        login_user user
        get :index, params: { chat_group_id: chat_groups.first.id }
      end

      it "assigns the requested chat_group to @chat_group" do
        expect(assigns(:chat_group)).to eq chat_groups.first
      end

      it "assigns the requested chat_groups to @chat_groups" do
        expect(assigns(:chat_groups)).to be_decorated
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
    context "when user signed in" do
      before do
        login_user user
        get :index, params: { chat_group_id: chat_groups.first.id }
      end

      it "assigns the requested chat_group to @chat_group" do
        expect(assigns(:chat_group)).to eq chat_groups.first
      end

      it "assigns the requested chat_groups to @chat_groups" do
        expect(assigns(:chat_groups)).to be_decorated
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

end
