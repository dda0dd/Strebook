class BookStoreTag < ApplicationRecord
# タグ機能実装のモデル(book_storeとtagの中間テーブル)
  # book_storesテーブルとのアソシエーション記載(タグ機能実装で)
  belongs_to :book_store
  # tagsテーブルとのアソシエーション記載(タグ機能実装で)
  belongs_to :tag
end
