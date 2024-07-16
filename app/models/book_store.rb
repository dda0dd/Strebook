class BookStore < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
    # guest/sessions_controller.rbの.guestメソッドを定義
    def self.guest
      # データの検索・作成を自動で判断して処理する(!=処理失敗時にエラー発生させる)
      find_or_create_by!(name: "guestbook_store", age: 1879) do |book_store|
        # ランダムな文字列を生成するRubyのメソッド(パスワードをランダムな文字列に設定)
        book_store.password = SecureRandom.urlsafe_base64
        # nameをguestcustomerに固定
        book_store.name = "guestbook_store"
      end
    end
    # def~endで定義されている
    def guest?
      #ゲストログイン時はif~end内を表示しない(==論理演算子の比較の意味)
        # nameがguestbook_storeの場合はbook_stores/showの22行目が実行される
      name == "guestbook_store"
    end
    # アソシエーション(投稿)
    has_many :posts
end
