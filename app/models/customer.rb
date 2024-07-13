class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

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
  # メールアドレスがゲスト会員のものか判定し、trueかfalseの値を返す(guest_customer?メソッド定義で複数箇所に同じメソッド共有)
  # def guest_customer?
  #   name == guest_customer
  # end

end
