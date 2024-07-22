class BookStore::CommentsController < ApplicationController

  def index
    # 特定の投稿に紐づく全ての感想コメントを表示
      # .page(params[:page]).per(5)でページネーション追記
    @thoughtse_comments = Post.find(params[:post_id]).thoughtse_comments.page(params[:page]).per(5)
  end

  def search
  end
end
