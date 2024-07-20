class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end
  # 特定の投稿に紐づく感想コメント一覧表示(book_store/posts/show)
  def show
    @post = Post.find(params[:id])
    @book_store = @post.book_store
    @thoughtse_comments = ThoughtseComment.all
    @thoughtse_comment = ThoughtseComment.new
  end

  def search
    # 検索フォームから情報を受け取る params[:range](検索モデル)
    # searches/search.htmlの"<%= @word %>"を定義
      @word = params[:word]
      # 検索フォームから情報を受け取るparams[:word](検索ワード)
        # pluck(:id)でIDだけ持ってくる
          # ("address LIKE?", "%#{@word}%")で部分一致検索
            # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
              # book_stores_idsはオリジナルの名前
      book_stores_ids = BookStore.where("address LIKE?", "%#{@word}%").pluck(:id)
      # where=Postの中(右の括弧内)を検索する
        # book_store_idでbook_store_idsを検索する
      @posts = Post.where(book_store_id: book_stores_ids)
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "public/posts/index"
  end
end