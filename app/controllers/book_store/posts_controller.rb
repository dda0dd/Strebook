class BookStore::BostsController < ApplicationController

  # 投稿データを保存するためにcreateアクションを記述
  def create
    # フォームに入力されたデータ(body,title,image)が@bookに格納される
    @book = Book.new(book_params)
    # @book(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーのID)に指定することで投稿データに、今ログイン中のユーザーのIDを持たせる
    @book.user_id = current_user.id
# save（保存のメソッド）
    if @book.save
# フラッシュメッセージ(books/showへリンク)if~end
      flash[:notice] = "You have created book successfully."
# アクションを通してviewを指定（redirect_to）
      redirect_to book_path(@book.id)
# バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbooks/new.html.erbが表示され投稿ページを再表示する設定
    else
      @books = Book.all
# @userを定義
      @user = current_user
# 直接viewを指定
      render :index
    end
  end

  def edit
    
  end

  def update
  end
  
  # 投稿を削除するdestroyアクションの処理(投稿の削除後は一覧に遷移)記述
  def destroy
     book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
end
