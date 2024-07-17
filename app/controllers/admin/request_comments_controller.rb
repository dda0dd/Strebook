class Admin::RequestCommentsController < ApplicationController

  # リクエストコメントを一覧で表示
  def index
    @request_comments = RequestComment.all
  end

  # リクエストコメントの一覧に削除ボタン設置して削除
  def destroy
    @request_comment = RequestComment.find(params[:id])
    @request_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
        # redirect_to book_path(params[:book_id])
  end
end
