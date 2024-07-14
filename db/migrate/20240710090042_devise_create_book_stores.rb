# frozen_string_literal: true

class DeviseCreateBookStores < ActiveRecord::Migration[6.1]
  def change
    create_table :book_stores do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      # 書店情報記述カラム記述
        # 書店名
        t.string :name, null: false, default: ""
        # パスワード(上記に記載があるので記述しない)
        # 住所
        t.string :address, null: false, default: ""
        # 電話番号
        t.string :telephone_number, null: false, default: ""
        # 創立年齢
        t.integer :age, null: false, default: ""
        # 会員ステータス(退会機能のため)
        t.boolean :is_active, null: false, default: "TRUE"

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    # add_index :book_stores, :email,                unique: true
    add_index :book_stores, :reset_password_token, unique: true
    # add_index :book_stores, :confirmation_token,   unique: true
    # add_index :book_stores, :unlock_token,         unique: true
  end
end
