class CreateCustomerTags < ActiveRecord::Migration[6.1]
  def change
    create_table :customer_tags do |t|

      t.timestamps

      # タグ(お客様)カラム記述
        # 会員(お客様)ID
        t.integer :customer_id, null: false
        # タグ名
        t.string :tag_name, null: false, default: ""

    end
  end
end
