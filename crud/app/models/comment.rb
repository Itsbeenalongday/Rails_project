class Comment < ApplicationRecord
  belongs_to :post # n개의 댓글이 하나의 게시물에 속함
  belongs_to :user
end
