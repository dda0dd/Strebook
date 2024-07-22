class BookStore::CommentsController < ApplicationController

  def index
    @thoughtse_comments = Post.find(params[:post_id]).thoughtse_comments
  end

  def search
  end
end
