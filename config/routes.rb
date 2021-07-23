Rails.application.routes.draw do
  resources :customers
  post '/sign_in', controller: :users, action: :sign_in
  post '/sign_up', controller: :users, action: :sign_up
  delete '/sign_out', controller: :users, action: :sign_out

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
