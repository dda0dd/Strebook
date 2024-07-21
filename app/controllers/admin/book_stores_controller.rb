class Admin::BookStoresController < ApplicationController

  def index
    # book_storeモデルの全てのデータ取得
    @book_stores = BookStore.all.page(params[:page]).per(5)
  end

  # 書店マイページ表示されるように設定
  def show
    @book_store = BookStore.find(params[:id])
    # @book_storeを定義
    @book_store = current_book_store
    @book_store_new = BookStore.new
  end
  # バリデーションの設定
  def edit
     @book_store = BookStore.find(params[:id])
    # アクセス制限の記述（viewにも記述）
    unless @book_store == current_book_store.id
      redirect_to book_stores_path
    end
  end
  # # 書店情報更新の設定を記述
  # def update
  #   # フォームに入力されたデータ(body,title,image)が@bookに格納される
  #   @book = Book.find(params[:id])
  #   # @book(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーのID)に指定することで投稿データに、今ログイン中のユーザーのIDを持たせる
  #   if @book.update(book_params)
  #     # フラッシュメッセージ(books/showへリンク)
  #     flash[:notice] = "You have updated book successfully."
  #     redirect_to book_path(@book.id)
  #   # バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbooks/new.html.erbが表示され投稿ページを再表示する設定
  #   else
  #     render :edit
  #   end
  # end

  def search
    # 検索フォームから情報を受け取る params[:range](検索モデル)
      # @wordにはtrueとfalseの情報が入っている
      @word = params[:is_active]
      # 条件分岐(有効か退会時はif~end内実行する)
      if @word.present?
       @book_stores = BookStore.where(is_active: @word)
      else
      # 上記の条件に当てはまらない時は下記実行する
       @book_stores = BookStore.all
      end
      # 検索フォームから情報を受け取るparams[:word](検索ワード)
        # pluck(:id)でIDだけ持ってくる
          # ("address LIKE?", "%#{@word}%")で部分一致検索
            # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
      # book_stores_ids = BookStore.where("address LIKE?", "%#{@word}%").pluck(:id)
      # where=Postの中(右の括弧内)を検索する
        # book_store_idでbook_store_idsを検索する

    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/book_stores/index"
  end

   private

# book_paramsメソッドでフォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェック
  def book_store_params
    params.require(:book_store).permit(:name, :image, :body)
  end
end
