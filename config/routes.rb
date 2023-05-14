Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/login', to: 'users#login'
  post '/register', to: 'users#register'

  get '/conversations', to: 'conversations#index'
  get '/conversations/:id', to: 'conversations#show'
  get '/conversations/:id/messages', to: 'conversations#messages'

  post '/messages', to: 'messages#create'
end
