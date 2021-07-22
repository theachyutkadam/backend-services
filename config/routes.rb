Rails.application.routes.draw do
  # post 'users/sign_in'
  post '/sign_in', controller: :users, action: :sign_in
  post '/sign_up', controller: :users, action: :sign_up

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
