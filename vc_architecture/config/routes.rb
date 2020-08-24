Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index" # localhost:3000접속시 보여주는 페이지 지정
  get '/attack', to: 'home#attack'
  get '/defense', to: 'home#defense'
end
