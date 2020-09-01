Rails.application.routes.draw do
  devise_for :users
    path: 'user', # 컨트롤러 이름
    path:_names: {sign_in: 'login', sign_out: 'logout'} # 액션 이름
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  resources :posts, controller: "home" 
  # 컨트롤러는 home인데, 만들어진 url은 posts를 사용하니까 컨트롤러 지정을 따로해줘야한다. 

  #get 'home/index'
  ## get 'home/index' => home#index
  ## home/index가 get방식으로 요청되면 home controller의 index액션을 실행
  ## 이게 없으면 redirect_to '/home/index'에서 에러가 난다
  #get 'home/new'
  #post 'home/create', as: 'posts'

  ## url과 action이 같다면 단축이가능한데
  ## 이제 destroy와 destroy/:post_id로 url이 구분되므로 위와같이 단축할 수 없다. 
  ## 아래와 같이 url이 요청되면 home controller의 destroy액션으로 이동해라를 명시해야함
  #get 'home/destroy/:post_id', to: 'home#destroy', as: 'home_destroy'
  ## /post_id, 문자그대로 post_id url이 됨
  ## /:post_id, post_id를 변수로 만들어 id를 저장할 수 있다.

  ## 수정하는 공간으로 라우팅
  #get 'home/edit/:post_id' => 'home#edit'
  ## 수정을 반영하기 위한 라우팅
  #patch 'home/update/:post_id' => 'home#update', as: 'post'

end
