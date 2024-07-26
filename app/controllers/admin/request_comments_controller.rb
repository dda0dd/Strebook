class Admin::RequestCommentsController < ApplicationController

  # リクエストコメントを一覧で表示
  def index
    @request_comments = RequestComment.all.page(params[:page]).per(5)
  end

  # リクエストコメントの一覧に削除ボタン設置して削除
  def destroy
    @request_comment = RequestComment.find(params[:id])
    @request_comment.destroy
    # コメント削除後は行う前（admin/request_comments/index）に遷移記述
    redirect_to admin_request_comments_path
  end

  def search
    # 検索フォームから情報を受け取る params[:word](検索モデル)
    @word = params[:word]
    # ("content LIKE?", "%#{@word}%")で部分一致検索
      # where=RequestCommentの中(右の括弧内)を検索する
    @request_comments = RequestComment.where("content LIKE?", "%#{@word}%").page(params[:page]).per(5)
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/request_comments/index"
  end
end
