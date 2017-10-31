Rails.application.routes.draw do
  devise_for :users, only: [:session, :registrations]

  root "chat_groups#index"

  resources :users, only: [:edit, :update]
  resources :chat_groups, only: [:new, :create, :edit, :update] do
    resources :messages, only: [:index, :create]
  end
end
