class Tag < ApplicationRecord
  # 中間テーブル(book_store_tags)とのアソシエーション記載
  has_many :book_store_tags, dependent: :destroy
  # book_storesテーブルとのアソシエーション記載(タグ機能実装で)
  has_many :book_stores, through: :book_store_tags
end
