class Public::SearchesController < ApplicationController
  # 検索機能記述
  before_action :authenticate_user!
  def search
    # 検索フォームから情報を受け取る params[:range](検索モデル)
      # range=自分で定義した文字を記述している（他の文字でも良い）
    @range = params[:range]
    # searches/search.htmlの"<%= @word %>"を定義
    @word = params[:word]
    # if文で検索モデルUser or Bookで条件分岐
    if @range == "User"
      # 検索フォームから情報を受け取る params[:search](検索方法),params[:word](検索ワード)
      @users = User.looks(params[:search], params[:word])
    else
      # looksメソッドで検索内容取得（）内、変数に代入（@users,@booksに）User,Bookモデル内検索結果代入
      @books = Book.looks(params[:search], params[:word])
    end
    # user.rb,book.rbに条件分岐を追記（検索方法による切替を行うため）
  end
end
