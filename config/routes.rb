Rails.application.routes.draw do
  # devise_for :book_storesを下記に書き換え(devise_forの後に生成したコントローラがどこに存在するかの記述)
    # 書店(新規登録・ログイン)
  devise_for :book_stores, skip: [:passwords], controllers: {
    registrations: "book_store/registrations",
    sessions: 'book_store/sessions'
  }
  # skipオプションで不要ルーティングを削除(管理者登録：パスワード変更)
    # サイト管理者(ログイン)
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
    # お客様(新規登録・ログイン)
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
