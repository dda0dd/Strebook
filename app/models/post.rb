class Post < ApplicationRecord

  # ヘッダーに投稿リンクを表示しない処理
  def guest?
    #ゲストログイン時はif~end内を表示しない(==論理演算子の比較の意味)
      # nameがguestbook_storeの場合は
    name == "guestbook_store"
  end
  belongs_to :book_store
  # BookCommentモデルとの関連付け（BookCommentモデルを複数持つ=has_manyで表す）
  has_many :book_comments, dependent: :destroy
end
