class BookStore < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
    # バリデーション記載(書店名が空の場合はバリデーション実行される)全てのモデルにバリデーション
    validates :name, presence: true
    validates :age, presence: true
    validates :address, presence: true
    validates :telephone_number, presence: true
    # on: :createで新規会員登録時のみバリデーションがかかるように設定
    validates :password, length: { minimum: 8 }, on: :create
    # アソシエーション(投稿)
    has_many :posts, dependent: :destroy
    # 中間テーブル(book_store_tags)とのアソシエーション記載
    has_many :book_store_tags, dependent: :destroy
    # tagsテーブルとのアソシエーション記載(タグ機能実装で)
    has_many :tags, through: :book_store_tags
    # guest/sessions_controller.rbの.guestメソッドを定義
  def self.guest
    # データの検索・作成を自動で判断して処理する(!=処理失敗時にエラー発生させる)
    find_or_create_by!(name: "guestbook_store", age: 1879) do |book_store|
      # ランダムな文字列を生成するRubyのメソッド(パスワードをランダムな文字列に設定)
      book_store.password = SecureRandom.urlsafe_base64
      # nameをguestcustomerに固定
      book_store.name = "guestbook_store"
      book_store.address = "大阪府〇〇市〇〇町7-6-11"
      book_store.telephone_number = "072-0000-0000"
    end
  end
  # def~endで定義されている
  def guest?
    #ゲストログイン時はif~end内を表示しない(==論理演算子の比較の意味)
      # nameがguestbook_storeの場合はbook_stores/showの22行目が実行される
    name == "guestbook_store"
  end

  def save_tags(tags)
    # タグをスペース区切りで分割し配列にする
      #   連続した空白も対応するので、最後の“+”がポイント
    tag_list = tags.split(/[[:blank:]]+/)
    # 自分自身に関連づいたタグを取得する
    current_tags = self.tags.pluck(:name)
    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
      #   -- 記事更新時に削除されたタグ
    old_tags = current_tags - tag_list
    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
      #   -- 新規に追加されたタグ
    new_tags = tag_list - current_tags
    # tag_mapsテーブルから、(1)のタグを削除
      #   tagsテーブルから該当のタグを探し出して削除する
    old_tags.each do |old|
      # tag_mapsテーブルにあるpost_idとtag_idを削除
        #   後続のfind_byでtag_idを検索
      self.tags.delete Tag.find_by(name: old)
    end
    # tagsテーブルから(2)のタグを探して、tag_mapsテーブルにtag_idを追加する
    new_tags.each do |new|
      # 条件のレコードを初めの1件を取得し1件もなければ作成する
        # find_or_create_by : https://railsdoc.com/page/find_or_create_by
      new_post_tag = Tag.find_or_create_by(name: new)
      # tag_mapsテーブルにpost_idとtag_idを保存
        #   配列追加のようにレコードを渡すことで新規レコード作成が可能
      self.tags << new_post_tag
    end
  end
  # ActiveStorageで書店の詳細に背景画像を表示するため、book_store.rbに宣言追記
  has_one_attached :image
end
