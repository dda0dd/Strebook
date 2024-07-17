class BookStore::RequestCommentsController < ApplicationController

  def index
    @request_comments = RequestComment.all
  end
end