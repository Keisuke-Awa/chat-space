Rails.application.routes.draw do
  devise_for :users, only: [:session, :registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "chat_groups#index"

  resources :users, only: [:edit, :update]
  resources :chat_groups, only: [:new, :create, :edit, :update]
end
