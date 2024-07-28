class BookStore::TagsController < ApplicationController

  def create
  end

  def index
    # 全てのタグ取得
    @tags = Tag.all
  end

  def destroy
    Tag.find(params[:id]).destroy()
    # 書店マイページに遷移
    redirect_to book_store_book_store_path(current_book_store.id)
  end
end
