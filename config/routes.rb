# == Route Map
#
#                   Prefix Verb   URI Pattern                                    Controller#Action
#         new_user_session GET    /users/sign_in(.:format)                       devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                       devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                      devise/sessions#destroy
# cancel_user_registration GET    /users/cancel(.:format)                        devise/registrations#cancel
#    new_user_registration GET    /users/sign_up(.:format)                       devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                          devise/registrations#edit
#        user_registration PATCH  /users(.:format)                               devise/registrations#update
#                          PUT    /users(.:format)                               devise/registrations#update
#                          DELETE /users(.:format)                               devise/registrations#destroy
#                          POST   /users(.:format)                               devise/registrations#create
#                     root GET    /                                              chat_groups#index
#                edit_user GET    /users/:id/edit(.:format)                      users#edit
#                     user PATCH  /users/:id(.:format)                           users#update
#                          PUT    /users/:id(.:format)                           users#update
#      chat_group_messages GET    /chat_groups/:chat_group_id/messages(.:format) messages#index
#                          POST   /chat_groups/:chat_group_id/messages(.:format) messages#create
#              chat_groups POST   /chat_groups(.:format)                         chat_groups#create
#           new_chat_group GET    /chat_groups/new(.:format)                     chat_groups#new
#          edit_chat_group GET    /chat_groups/:id/edit(.:format)                chat_groups#edit
#               chat_group PATCH  /chat_groups/:id(.:format)                     chat_groups#update
#                          PUT    /chat_groups/:id(.:format)                     chat_groups#update
#

Rails.application.routes.draw do
  devise_for :users, only: [:session, :registrations]

  root "chat_groups#index"

  resources :users, only: [:edit, :update]
  resources :chat_groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end
end
