class Public::BookStoresController < ApplicationController
  
  # 投稿一覧で表示する全ての画像をコントローラで取得
  def index
    # 1ページ分の決められた数のデータだけを、新しい順に取得するに変更(kaminari)
  # 今回ページネーションは必要ない
    # @books = Book.page(params[:page])
# modelを全て選択
    @books = Book.all
# @userを定義
    @user = current_user
# @bookを定義
    @book = Book.new
  end

  def show
  end
end
