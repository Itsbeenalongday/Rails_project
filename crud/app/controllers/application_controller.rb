class ApplicationController < ActionController::Base

    before_action :configure_permitted_parameters, 
        if: :devise_controller?
    # devise와 관련있는 컨트롤러 일 때만 실행되게 만듦

    def configure_permitted_parameters
        # keys에 자신이 추가한 속성을 써준다.
        # 가입할 때 추가속성 :sign_up(keyword)
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        # 수정할 때 추가속성 :account_update(keyword)
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
end
