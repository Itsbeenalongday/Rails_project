class HomeController < ApplicationController
    before_action :set_post, only: [:edit, :update, :destroy, :show]
    before_action :authenticate_user!, only: [:edit, :destroy]

    def index
        @posts = Post.all
    end

    def new
        @post = Post.new
        3.times {@post.hashtags.new}
    end

    def create
        post = Post.new(post_params)# 테이블 한 행 추가, 한 행을 만들고(객체), @post라는 변수에 저장
       # post.title = params[:post][:title] # params 객체의 post_title 속성을 title에 저장
       # post.content = params[:post][:content] # params 객체의 post_content 속성을 content에 저장
       3.times do |i|
        hashtags = hashtag_params[:hashtags_attributes][:"#{i}"][:"title"]
        hashtags = Hashtag.find_or_create_by(title: hashtags)
        post.hashtags << hashtags
       end
       respond_to do |format|
            if post.save # 테이블에 쓴 내용을 저장
                format.html do
                    redirect_to posts_path, # index로 redirection
                    notice: "게시물이 성공적으로 생성되었습니다."    
                end
            else
                format.html do
                    render :new
                end
            end
        end
    end

    def show
    end

    def edit
    end

    def update
    # 인스턴스 변수를 사용하는 경우는 view파일에서 사용해야 할 때 사용
       # post = Post.find(params[:id])
       # post.title = params[:post][:title]
       # post.content = params[:post][:content]
       respond_to do |format| # 지정된 형식에 따라 다른 템플릿을 출력(html, json) 
            if @post.update(post_params)
                format.html do
                    redirect_to posts_path,
                    notice: "게시물이 성공적으로 수정되었습니다."
                end
            else
                format.html do
                    render :edit
                end
            end
        end
    end

    def destroy
        # 아이디을 받아서 그것을 Post내에서 찾는다
        #Post.find(params[:id]).destroy
        # 해당 게시물 삭제
        @post.destroy
        redirect_to posts_path
    end

    private
    def post_params
        params.require(:post).permit(:title, :content) # 자동으로 마지막 줄이 리턴되므로
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def hashtag_params
        params.require(:post).permit(hashtags_attributes: [:title])
    end
end
