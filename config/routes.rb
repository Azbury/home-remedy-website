Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  get '/signin', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  root 'sessions#home'
  delete 'logout' => 'sessions#destroy'
end
