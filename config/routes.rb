Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments
  end

  resources :users
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
