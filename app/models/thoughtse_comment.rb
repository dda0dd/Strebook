class ThoughtseComment < ApplicationRecord
  # UserモデルもBookモデルも関連付けられるのは1つだけなのでbelong_to記述
  belongs_to :customer
  belongs_to :post

  # 空のコメントは保存できないバリデーション
  validates :content, presence:true
  
  # 検索方法の分岐定義(検索方法毎に適した検索が行われる)
  def self.looks(search, word)
    # perfect_match=完全一致（検索方法）送られてきたsearchで条件分岐
    if search == "perfect_match"
      # title=検索対象booksテーブル内カラム名
      @thoughtse_comments = ThoughtseComment.where("title LIKE ?", "#{word}")
    # forward_match=前方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "forward_match"
      # 完全一致以外の検索方法は #{word}前後か両方に % 追記で定義
      @thoughtse_comments = ThoughtseComment.where("title LIKE ?", "#{word}%")
    # backward_match=後方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "backward_match"
      # whereメソッドでデータベースから該当データ取得、変数(@user)に代入
      @thoughtse_comments = ThoughtseComment.where("title LIKE ?", "%#{word}")
    # partial_match=部分一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "partial_match"
      @thoughtse_comments = ThoughtseComment.where("title LIKE ?", "%#{word}%")
    else
      @thoughtse_comments = ThoughtseComment.all
    end
  end
end
