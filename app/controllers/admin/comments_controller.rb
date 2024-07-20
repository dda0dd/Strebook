class Admin::CommentsController < ApplicationController

  def index
    # 特定の投稿に紐づく全ての感想コメントを表示
    @thoughtse_comments = ThoughtseComment.all
  end

  def destroy
    @thoughtse_comment = ThoughtseComment.find(params[:id])
    @thoughtse_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
        # redirect_to book_path(params[:book_id])
  end
  
  def search
    # 検索フォームから情報を受け取る params[:range](検索モデル)
    # searches/search.htmlの"<%= @word %>"を定義
      @word = params[:word]
      # 検索フォームから情報を受け取るparams[:word](検索ワード)
        # pluck(:id)でIDだけ持ってくる
          # ("address LIKE?", "%#{@word}%")で部分一致検索
            # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
      book_stores_ids = BookStore.where("address LIKE?", "%#{@word}%").pluck(:id)
      # where=Postの中(右の括弧内)を検索する
        # book_store_idでbook_store_idsを検索する
      @posts = Post.where(book_store_id: book_stores_ids)
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/comments/index"
  end
end
