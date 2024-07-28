class Public::ThoughtseCommentsController < ApplicationController

  def create
    @thoughtse_comment = current_customer.thoughtse_comments.new(thoughtse_comment_params)
    @thoughtse_comment.save!
    # 感想コメント後はお客様マイページ（customers/show）に遷移記述
    redirect_back(fallback_location: root_url)
  end

  def destroy
    @thoughtse_comment = ThoughtseComment.find(params[:id])
    @thoughtse_comment.destroy
    # コメント削除後は行う前（public/posts/show）に遷移記述
    redirect_to public_post_path(params[:post_id])
  end

   private

  def thoughtse_comment_params
    # starカラム追加したので保存できるようにデータ操作許可(permitに:starで追加で保存できる)
    params.require(:thoughtse_comment).permit(:content, :post_id, :evaluation_score)
  end
end
