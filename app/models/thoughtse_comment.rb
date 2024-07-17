class ThoughtseComment < ApplicationRecord
  # UserモデルもBookモデルも関連付けられるのは1つだけなのでbelong_to記述
  belongs_to :user
  belongs_to :book

# 空のコメントは保存できないバリデーション
  validates :comment, presence:true
end
