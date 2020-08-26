class HomeController < ApplicationController
    
    def index
        @posts = Post.all
    end

    def new
        post = Post.new # 테이블 한 행 추가, 한 행을 만들고(객체), @post라는 변수에 저장 
    end

    def create
        post = Post.new # 테이블 한 행 추가, 한 행을 만들고(객체), @post라는 변수에 저장 
        post.title = params[:post_title] # params 객체의 post_title 속성을 title에 저장
        post.content = params[:post_content] # params 객체의 post_content 속성을 content에 저장
        post.save # 테이블에 쓴 내용을 저장

        redirect_to '/home/index' # index로 redirection
    end

    def edit
        @post = Post.find(params[:post_id])
    end

    def update
        # 인스턴스 변수를 사용하는 경우는 view파일에서 사용해야 할 때 사용
        post = Post.find(params[:post_id])
        post.title = params[:post_title]
        post.content = params[:post_content]
        post.save

        redirect_to "/home/index"
    end

    def destroy
        # 아이디을 받아서 그것을 Post내에서 찾는다
        Post.find(params[:post_id]).destroy
        # 해당 게시물 삭제
        redirect_to "/home/index"
    end
end
