class BookStore::PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  # 特定の投稿に紐づく感想コメント一覧表示(book_store/posts/show)
  def show
    @thoughtse_comments = ThoughtseComment.all
  end
  # 投稿作成
  def new
    @post = Post.new
  end
  # 投稿データを作成・保存
  def create
    # フォームに入力されたデータが@book_storeに格納される
    @post = Post.new(post_params)
    # @book_store(投稿データ)のbook_store_idを、current_book_store.id(今ログインしている書店のID)に指定することで投稿データに、今ログイン中の書店のIDを持たせる
    @post.book_store_id = current_book_store.id
    # save（保存のメソッド）
    if @post.save
      # タグの保存
      @post.save_tags(params[:post][:tag])
      # フラッシュメッセージ(book_stores/showへリンク)if~end
      flash[:notice] = "You have created book successfully."
      # アクションを通してviewを指定（redirect_to）
      redirect_to book_store_book_store_path(current_book_store)
    # バリデーションで保存できなかった時はsaveメソッドがfalseになり、renderでbook_stores/index.html.erbが表示され投稿ページを再表示する設定
    else
      @book_stores = Book_store.all
      # @book_storeを定義
      @book_store = current_book_store
      # 直接viewを指定
      render :index
    end
  end
  # 編集する書店の投稿を取得
  def edit
    @book_store = Book_store.find(params[:id])
  end
  # editで編集した投稿を更新
  def update
    @book_store = Book_store.find(params[:id])
    if @book_store.update(book_store_params)
      # タグの更新
      @post.save_tags(params[:post][:tag])
      flash[:notice] = "You have updated the book_store successfully."
      redirect_to book_store_path(@book_store)
    else
      render :edit
    end
  end
  # createで作成した投稿を削除(投稿の削除後は書店マイページに遷移)
  def destroy
    @book_store = Book_store.find(params[:id])
    book_store.destroy
    redirect_to book_stores_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
