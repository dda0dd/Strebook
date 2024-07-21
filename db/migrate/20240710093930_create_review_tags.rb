class CreateReviewTags < ActiveRecord::Migration[6.1]
  def change
    create_table :review_tags do |t|

      t.timestamps

      # タグ(お客様)とレビューの中間テーブル
        # 会員(書店)ID
        t.integer :book_store_id, null: false
        # タグ(お客様)ID
        t.integer :customer_tag_id, null: false
        # レビューID
        t.integer :review_id, null: false

    end
  end
end
