class Public::RequestCommentsController < ApplicationController

  def new
    @request_comment = RequestComment.new
  end
  # コメント作成し、データベースに保存記述
  def create
    @request_comment = current_customer.request_comments.new(request_comment_params)
    @request_comment.save!
    # リクエストコメント後はお客様マイページ（customers/show）に遷移記述
    redirect_to public_customer_path(current_customer)
  end
  # コメント削除機能
  def destroy
    @request_comment = RequestComment.find(params[:id])
    @request_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
    redirect_to public_customer_path(params[:id])
  end

  private

  def request_comment_params
    params.require(:request_comment).permit(:content)
  end
end
