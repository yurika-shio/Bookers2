Rails.application.routes.draw do
  devise_for :users
  root'homes#top'
  resources :books, only:[:create,:index,:show,:edit,:update,:destroy] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create,:destroy]
end
  resources :users, only: [:create,:index,:show, :edit, :update]
  get '/home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
