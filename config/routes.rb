Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :applications, only: [:index, :create, :show] do 
    resources :chats, only: [:index, :create, :show] 
  end
  post '/applications/:application_id/chats/:id', :to => 'chats#post_message'
  # Defines the root path route ("/")
  # root "articles#index"
end
