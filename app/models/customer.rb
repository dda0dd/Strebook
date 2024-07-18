class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

    has_many :request_comments
    # guest/sessions_controller.rbの.guestメソッドを定義
    def self.guest
      # データの検索・作成を自動で判断して処理する(!=処理失敗時にエラー発生させる)
      find_or_create_by!(name: "guestcustomer", age: 20) do |customer|
        # ランダムな文字列を生成するRubyのメソッド(パスワードをランダムな文字列に設定)
        customer.password = SecureRandom.urlsafe_base64
        # nameをguestcustomerに固定
        customer.name = "guestcustomer"
      end
    end
    # def~endで定義されている
    def guest?
      #ゲストログイン時はif~end内を表示しない(==論理演算子の比較の意味)
        # nameがguestcustomerの場合はcustomers/showの23行目が実行される
      name == "guest_customer"
    end
end
