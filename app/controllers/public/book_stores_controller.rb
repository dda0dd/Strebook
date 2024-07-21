class Public::BookStoresController < ApplicationController

  # 投稿一覧で表示する全ての画像をコントローラで取得
  def index
    # 1ページ分の決められた数のデータだけを、新しい順に取得するに変更(kaminari)
    # @book_stores = BookStore.page(params[:page])
    # modelを全て選択
    @book_stores = BookStore.all
    # @book_storeを定義
    @book_store = current_book_store
    # @book_storeを定義
    # @book_store = Book_store.new
  end

  def show
    # 書店情報を表示
    @book_store = BookStore.find(params[:id])
    # 書店の投稿を表示
    @book_store_posts = @book_store.posts.page(params[:page]).per(5)
  end
end
