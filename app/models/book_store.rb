class BookStore < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  # バリデーション記載(書店名が空の場合はバリデーション実行される)全てのモデルにバリデーション
  validates :name, presence: true
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
    # 検索方法の分岐定義(検索方法毎に適した検索が行われる)
  def self.looks(search, word)
# perfect_match=完全一致（検索方法）送られてきたsearchで条件分岐
    if search == "perfect_match"
# title=検索対象booksテーブル内カラム名
      @book = Book.where("title LIKE ?", "#{word}")
# forward_match=前方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "forward_match"
# 完全一致以外の検索方法は #{word}前後か両方に % 追記で定義
      @book = Book.where("title LIKE ?", "#{word}%")
# backward_match=後方一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "backward_match"
# whereメソッドでデータベースから該当データ取得、変数(@user)に代入
      @book = Book.where("title LIKE ?", "%#{word}")
# partial_match=部分一致（検索方法）送られてきたsearchで条件分岐
    elsif search == "partial_match"
      @book = Book.where("title LIKE ?", "%#{word}%")
    else
      @book = Book.all
    end
  end
  # ActiveStorageで書店の詳細に背景画像を表示するため、book_store.rbに宣言追記
  has_one_attached :image
end
