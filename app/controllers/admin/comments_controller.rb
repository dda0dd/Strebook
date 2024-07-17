class Admin::CommentsController < ApplicationController

  def index
    # 特定の投稿に紐づく全ての感想コメントを表示
    @thoughtse_comment = ThoughtseComments.all
  end

  def destroy
    @thoughtse_comment = ThoughtseComment.find(params[:id])
    @thoughtse_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
        # redirect_to book_path(params[:book_id])
  end
end
