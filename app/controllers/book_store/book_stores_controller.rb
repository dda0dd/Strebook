class BookStore::BookStoresController < ApplicationController
  # 権限の設定：ログインしていない書店が作業できないように設定
  before_action :authenticate_book_store!


  def show
    # 現在ログインしている書店
    @book_store = current_book_store
  end

  def edit
    @book_store = current_book_store
  end

  def update
    book_store = current_book_store
    book_store.update(book_store_params)
    # リダイレクト先に会員(書店)マイページ
    redirect_to book_store_path(params[:id])
  end
   # unsubscribe.htmlのlink_toでcurrent_book_storeを記述しているのでcontrollerに記述不要
  def unsubscribe
  end

  def withdraw
    current_book_store.update(is_active: false)
    reset_session
    #新規会員(書店)登録画面に遷移
    redirect_to root_path
  end

   private

  def book_store_params
    params.require(:book_store).permit(:name,
                                     :age,
                                     :address,
                                     :telephone_number
                                     )
  end
end