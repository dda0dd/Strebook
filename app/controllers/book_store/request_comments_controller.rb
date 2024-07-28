class BookStore::RequestCommentsController < ApplicationController

  def index
    @request_comments = RequestComment.all.page(params[:page]).per(5)
  end

  def search
    # 検索フォームから情報を受け取る params[:word](検索モデル)
    @word = params[:word]
    # ("content LIKE?", "%#{@word}%")で部分一致検索
      # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
        # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
    @request_comments = RequestComment.where("content LIKE?", "%#{@word}%").page(params[:page]).per(5)
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "book_store/request_comments/index"
  end
end