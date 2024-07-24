class CreateBookStoreTags < ActiveRecord::Migration[6.1]
  def change
    create_table :book_store_tags do |t|

      t.timestamps

      # タグ(書店)カラム記述
        # 会員(書店)ID
        t.integer :book_store_id, null: false
        t.integer :tag_id, null: false
    end
  end
end
