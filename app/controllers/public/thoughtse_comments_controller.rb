class Public::ThoughtseCommentsController < ApplicationController

  def create
    customer = Customer.find(params[:customer_id])
    # 下記はcomment =BookComment.new(book_comment_params)
    # comment.user_id = current_user.idの省略記述
    @thoughtse_comment = current_customer.book_store_thoughtse_comments.new(book_store_thoughtse_comment_params)
    @thoughtse_comment.customer_id = customer.id
    @thoughtse_comment.save
    # コメント後は行う前（books/show）に遷移記述
        # redirect_to book_path(book)
    
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

  def customer_thoughtse_comment_params
    params.require(:thoughtse_comment).permit(:comment)
  end
end
