class CreateRequestComments < ActiveRecord::Migration[6.1]
  def change
    create_table :request_comments do |t|

      t.timestamps

      # リクエストコメント機能カラム記述
        # 会員(お客様)ID
        t.integer :customer_id, null: false
        # リクエスト内容
        t.string :content, null: false, default: ""

    end
  end
end
