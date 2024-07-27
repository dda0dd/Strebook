class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all.page(params[:page]).per(5)
  end

  # リクエストコメントの一覧に削除ボタン設置して削除
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    # コメント削除後は行う前(admin/posts/index）に遷移記述
    redirect_to admin_posts_path
  end

  def search
    # 検索フォームから情報を受け取る params[:word](検索モデル)
    @word = params[:word]
    # フリーワードとタグを切り替えて検索する(range=範囲の意味)
    @range = params[:range]
    # ("content LIKE?", "%#{@word}%")で部分一致検索
      # where=Postの中(右の括弧内)を検索する
        # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
    if @range == "Word"
      @posts = Post.where("content LIKE?", "%#{@word}%").page(params[:page]).per(5)
      # 検索後に検索結果を下記ページに表示(検索後の遷移先)
      render "admin/posts/index"
    else
      # 書店のタグを部分一致で検索する
      tag_ids = Tag.where("name LIKE?", "%#{@word}%").pluck(:id)
      book_store_ids = BookStore.eager_load(:tags).where(tags: {id: tag_ids}).pluck(:id)
      @posts = Post.where(book_store_id: book_store_ids).page(params[:page]).per(5)
      # 検索後に検索結果を下記ページに表示(検索後の遷移先)
      render "admin/posts/index"
    end
  end
end