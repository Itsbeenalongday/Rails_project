Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # get 'home/index' => home#index
  # home/index가 get방식으로 요청되면 home controller의 index액션을 실행
  get 'home/new'
  post 'home/create'

end
