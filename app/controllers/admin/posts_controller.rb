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
    # 検索フォームから情報を受け取る params[:range](検索モデル)
    # searches/search.htmlの"<%= @word %>"を定義
      @word = params[:word]
      # 検索フォームから情報を受け取るparams[:word](検索ワード)
        # pluck(:id)でIDだけ持ってくる
          # ("address LIKE?", "%#{@word}%")で部分一致検索
            # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
      # book_stores_ids = BookStore.where("address LIKE?", "%#{@word}%").pluck(:id)
      # where=Postの中(右の括弧内)を検索する
        # book_store_idでbook_store_idsを検索する
          # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
      @posts = Post.where("content LIKE?", "%#{@word}%").page(params[:page]).per(5)
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/posts/index"
  end
end