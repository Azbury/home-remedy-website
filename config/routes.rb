Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :new, :index, :create] do
    resources :remedies, only: [:new, :index, :show]
  end
  resources :remedies, only: [:create, :index]
  get '/users/elderly', to: 'users#elderly'
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  root 'sessions#home'
  get '/logout' => 'sessions#destroy'
  delete 'logout' => 'sessions#destroy'
  match '/auth/github/callback', to: 'sessions#create', via: [:get, :post]
end
