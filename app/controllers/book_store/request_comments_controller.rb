class BookStore::RequestCommentsController < ApplicationController

  def index
    @request_comment = RequestComment.all
  end
end