class Admin::BookStoresController < ApplicationController

  def index
    # book_storeモデルの全てのデータ取得
    @book_stores = BookStore.all.page(params[:page]).per(5)
  end

  # 書店マイページ表示されるように設定
  def show
    @book_store = BookStore.find(params[:id])
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

  def unsubscribe
    @book_store = BookStore.find(params[:id])
  end

  def withdraw
    book_store = BookStore.find(params[:id])
    book_store.update(is_active: false)
    #管理者の書店一覧画面に遷移
    redirect_to admin_book_stores_path
  end

  def search
    # 検索フォームから情報を受け取る params[:word](検索モデル)
    @word = params[:is_active]
      # 条件分岐(有効か退会時はif~end内実行する)
    if @word.present?
      # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
      @book_stores = BookStore.where(is_active: @word).page(params[:page]).per(5)
    else
      # 上記の条件に当てはまらない時は下記実行する
        # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
      @book_stores = BookStore.all.page(params[:page]).per(5)
    end
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/book_stores/index"
  end

  private

  # book_paramsメソッドでフォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェック
  def book_store_params
    params.require(:book_store).permit(:name, :image, :body)
  end
end
