class HomeController < ApplicationController
    # 메소드는 액션하나하나에 대응되는 개념임
    def index

    end

    def attack
        @from = params[:userA] # params객체의 userA속성을 참조한 값을 인스턴스 변수에 담는다!, 메소드끼리 변수를 공유해야하므로 인스턴스변수를 만든다
        @to = params[:userB]
    end

    def defense
        @from = params[:userA]
        @to = params[:userB]
    end
end
