class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.timestamps

      # レビューカラム記述
        # 会員(お客様)ID
        t.integer :customer_id, null: false, default: ""
        # 会員(書店)ID
        t.integer :book_store_id, null: false, default: ""
        # 感想コメント
        t.string :thoughtse_comment, null: false, default: ""
        # 評価スコア
        t.float :evaluation_score, null: false, default: ""

    end
  end
end
