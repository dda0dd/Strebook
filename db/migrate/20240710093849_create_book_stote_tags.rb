class CreateBookStoteTags < ActiveRecord::Migration[6.1]
  def change
    create_table :book_stote_tags do |t|

      t.timestamps

      # タグ(書店)カラム記述
        # 会員(書店)ID
        t.integer :book_store_id, null: false, default: ""
        # タグ名
        t.string :tag_name, null: false, default: ""

    end
  end
end
