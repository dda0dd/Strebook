class ThoughtseComment < ApplicationRecord
  # UserモデルもBookモデルも関連付けられるのは1つだけなのでbelong_to記述
  belongs_to :customer
  belongs_to :post

  # 空のコメントは保存できないバリデーション
  validates :content, presence:true
  # validates :evaluation_score, presence:true
end
