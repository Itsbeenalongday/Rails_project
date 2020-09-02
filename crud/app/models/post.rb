class Post < ApplicationRecord
    has_many :comments # 하나의 게시물이 n개의 댓글, 복수형
end
