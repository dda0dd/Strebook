class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  
  def show
    @thoughtse_comments = ThoughtseComment.all
  end
end