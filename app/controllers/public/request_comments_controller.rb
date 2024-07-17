class Public::RequestCommentsController < ApplicationController

  def create
  end

  def destroy
  end
end
# コメント作成し、データベースに保存記述
  def create
    book = Book.find(params[:book_id])
# 下記はcomment =BookComment.new(book_comment_params)
# comment.user_id = current_user.idの省略記述
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = book.id
    @comment.save
# コメント後は行う前（books/show）に遷移記述
    # redirect_to book_path(book)

# 非同期通信記述
  # redirect_backを削除（redirect_toがない時Railsは自動で対応するJavaScriptファイルを探し。読み込む）
    # 非同期通信行う時はJavaScriptファイル（.js.erb）を使用でビュー更新
  end

# コメント削除機能
  def destroy
    @comment = BookComment.find(params[:id])
    @comment.destroy
# コメント削除後は行う前（books/show）に遷移記述
    # redirect_to book_path(params[:book_id])

# 非同期通信記述
  # redirect_backを削除（redirect_toがない時Railsは自動で対応するJavaScriptファイルを探し。読み込む）
    # 非同期通信行う時はJavaScriptファイル（.js.erb）を使用でビュー更新
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
