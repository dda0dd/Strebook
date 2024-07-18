class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  # 特定の投稿に紐づく感想コメント一覧表示(book_store/posts/show)
  def show
    @post = Post.find(params[:id])
    @book_store = @post.book_store
    @thoughtse_comments = ThoughtseComment.all
    @thoughtse_comment = ThoughtseComment.new
  end
end