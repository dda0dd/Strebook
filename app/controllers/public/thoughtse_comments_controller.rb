class Public::ThoughtseCommentsController < ApplicationController

  def create
    # customer = Customer.find(params[:customer_id])
    # 下記はcomment =BookComment.new(book_comment_params)
    # comment.user_id = current_user.idの省略記述
    @thoughtse_comment = current_customer.thoughtse_comments.new(thoughtse_comment_params)
    # @thoughtse_comment.customer_id = customer.id
    @thoughtse_comment.save!
    # 感想コメント後はお客様マイページ（customers/show）に遷移記述
    redirect_back(fallback_location: root_url)
    # 非同期通信記述
      # redirect_backを削除（redirect_toがない時Railsは自動で対応するJavaScriptファイルを探し。読み込む）
        # 非同期通信行う時はJavaScriptファイル（.js.erb）を使用でビュー更新
  end

  def destroy
    @thoughtse_comment = ThoughtseComment.find(params[:id])
    @thoughtse_comment.destroy
    # コメント削除後は行う前（books/show）に遷移記述
        # redirect_to book_path(params[:book_id])
    
    # 非同期通信記述
      # redirect_backを削除（redirect_toがない時Railsは自動で対応するJavaScriptファイルを探し。読み込む）
    # 非同期通信行う時はJavaScriptファイル（.js.erb）を使用でビュー更新
  end
  
   private

  def thoughtse_comment_params
    params.require(:thoughtse_comment).permit(:content, :post_id, :evaluation_score)
  end
end
