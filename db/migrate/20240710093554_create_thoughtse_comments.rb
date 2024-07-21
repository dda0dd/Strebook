class CreateThoughtseComments < ActiveRecord::Migration[6.1]
  def change
    create_table :thoughtse_comments do |t|

      t.timestamps

      # 感想コメント機能カラム記述
        # 会員(お客様)ID
        t.integer :customer_id, null: false
        # 投稿ID
        t.integer :post_id, null: false
        # 評価スコア
        t.float :evaluation_score, null: false
        # 感想内容
        t.string :content, null: false, default: ""

    end
  end
end
