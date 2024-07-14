class CreateThoughtseComments < ActiveRecord::Migration[6.1]
  def change
    create_table :thoughtse_comments do |t|

      t.timestamps

      # 感想コメント機能カラム記述
        # 会員(お客様)ID
        t.integer :customer_id, null: false
        # 会員(書店)ID
        t.integer :book_store_id, null: false
        # 評価スコア
        t.float :evaluation_score, null: false
        # 感想内容
        t.string :content, null: false, default: ""

    end
  end
end
