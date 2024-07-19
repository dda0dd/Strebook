class BookStore < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  # ActiveStorageで書店の詳細に背景画像を表示するためbook_store.rbに宣言追記
  has_one_attached :image
end
