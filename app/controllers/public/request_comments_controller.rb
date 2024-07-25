class Public::RequestCommentsController < ApplicationController
  # バリデーション記載(空の時に実行される)
  # validates :content, presence: true
  
  def new
    @request_comment = RequestComment.new
  end
  
  # コメント作成し、データベースに保存記述
  def create
    # customer = Customer.find(params[:customer_id])
    # 下記はcomment =BookComment.new(book_comment_params)
    # comment.user_id = current_user.idの省略記述
    @request_comment = current_customer.request_comments.new(request_comment_params)
    @request_comment.save!
    # リクエストコメント後はお客様マイページ（customers/show）に遷移記述
    redirect_to public_customer_path(current_customer)

    # 非同期通信記述
      # redirect_backを削除（redirect_toがない時Railsは自動で対応するJavaScriptファイルを探し。読み込む）
        # 非同期通信行う時はJavaScriptファイル（.js.erb）を使用でビュー更新
  end

  # コメント削除機能
  def destroy
    @request_comment = RequestComment.find(params[:id])
    @request_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
    redirect_to public_customer_path(params[:id])

    # 非同期通信記述
      # redirect_backを削除（redirect_toがない時Railsは自動で対応するJavaScriptファイルを探し。読み込む）
    # 非同期通信行う時はJavaScriptファイル（.js.erb）を使用でビュー更新
  end

  private

  def request_comment_params
    params.require(:request_comment).permit(:content)
  end
end
