class Admin::BookStoresController < ApplicationController

  def index
  end
  
  # 詳細画面が表示されるように設定
  def show
     @book = Book.find(params[:id])
# @userを定義
    @user = @book.user
    @book_new = Book.new
  end
  # バリデーションの設定
  def edit
     @book = Book.find(params[:id])
# アクセス制限の記述（viewにも記述）
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
  # 書店情報更新の設定を記述
  def update
    # フォームに入力されたデータ(body,title,image)が@bookに格納される
    @book = Book.find(params[:id])
 # @book(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーのID)に指定することで投稿データに、今ログイン中のユーザーのIDを持たせる
    if @book.update(book_params)
# フラッシュメッセージ(books/showへリンク)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
# バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbooks/new.html.erbが表示され投稿ページを再表示する設定
    else
      render :edit

    end
  end
  
   private

# book_paramsメソッドでフォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェック
  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
