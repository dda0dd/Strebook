class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|

      t.timestamps
      
      # タグ(書店)とレビューの中間テーブルカラム記述
        # 会員(お客様)ID
        t.integer :customer_id, null:false
        # タグ(書店)ID
        t.integer :book_store_tag_id, null:false
        # レビューID
        t.integer :review_id, null:false
        
    end
  end
end
