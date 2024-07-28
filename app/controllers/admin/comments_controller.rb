class Admin::CommentsController < ApplicationController

  def index
    # 特定の投稿に紐づく全ての感想コメントを表示
    @thoughtse_comments = Post.find(params[:id]).thoughtse_comments.page(params[:page]).per(5)
  end

  def destroy
    @thoughtse_comment = ThoughtseComment.find(params[:id])
    @thoughtse_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
    redirect_to admin_comments_path(id: @thoughtse_comment.post_id)
  end

  def search
    # 検索フォームから情報を受け取る params[:word](検索モデル)
    @word = params[:word]
    # ("content LIKE?", "%#{@word}%")で部分一致検索
      # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
    @thoughtse_comments = ThoughtseComment.where("content LIKE?", "%#{@word}%").page(params[:page]).per(5)
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/comments/index"
  end
end
