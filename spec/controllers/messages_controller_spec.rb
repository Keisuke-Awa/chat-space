require 'rails_helper'

describe MessagesController do
  let(:user) { create(:user) }


  describe 'GET #index' do
    let!(:chat_group) { user.chat_groups.first }
    let!(:messages) { chat_group.messages }
    context "when user signed in" do
      before do
        login_user user
        get :index, params: { chat_group_id: chat_group.id }
      end

      it "assigns the requested chat_group to @chat_group" do
        expect(assigns(:chat_group)).to eq chat_group
      end

      it "@chat_group is decorated with ChatGroupDecorator" do
        expect(assigns(:chat_group)).to be_decorated_with ChatGroupDecorator
      end

      it "assigns the requested messages to @messages" do
        expect(assigns(:messages)).to eq messages
      end

      it "@messages are decorated with MessageDecorator" do
        expect(assigns(:messages)).to be_decorated_with Draper::CollectionDecorator
      end

      it "assigns the requested chat_groups to @chat_groups" do
        expect(assigns(:chat_groups)).to eq user.chat_groups
      end

      it "@chat_groups are decorated with ChatGroupsDecorator" do
        expect(assigns(:chat_groups)).to be_decorated_with Draper::CollectionDecorator
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
        get :index, params: { chat_group_id: chat_group.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #create' do
    let!(:chat_group) { create(:chat_group) }
    context "when user signed in" do
      before do
        login_user user
        post :create, params: { chat_group_id: chat_group.id, message: message_params }
      end

      context "with valid message attributes" do
        let(:message_params) { attributes_for(:message) }

        it "assigns the requested chat_group to @chat_group" do
          expect(assigns(:chat_group)).to eq chat_group
        end

        it "@chat_group is decorated with ChatGroupDecorator" do
          expect(assigns(:chat_group)).to be_decorated_with ChatGroupDecorator
        end

        it "creates a new message" do
          expect{
            post :create, params: { chat_group_id: chat_group.id, message: message_params }
          }.to change(Message, :count).by(1)
        end

        it "redirects to the :index template with flash notice" do
          expect(response).to redirect_to chat_group_messages_path(chat_group)
          expect(flash[:notice]).to eq('メッセージが作成されました')
        end
      end

      context "with invalid message attributes" do
        let(:message_params) { attributes_for(:message, body: nil, image: nil) }

        it "assigns the requested chat_group to @chat_group" do
          expect(assigns(:chat_group)).to eq chat_group
        end

        it "@chat_group is decorated with ChatGroupDecorator" do
          expect(assigns(:chat_group)).to be_decorated_with ChatGroupDecorator
        end

        it "cannot create a new message" do
          expect {
            post :create, params: { chat_group_id: chat_group.id, message: message_params }
          }.to change(Message, :count).by(0)
        end

        it "redirects to the :index template with flash alert" do
          expect(response).to redirect_to chat_group_messages_path(chat_group)
          expect(flash[:alert]).to eq('メッセージを入力してください')
        end
      end

    end

    context "when user not signed in" do
      let(:message_params) { attributes_for(:message) }
      it "redirect to new_user_session_path " do
        post :create, params: { chat_group_id: chat_group.id, message: message_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

end


