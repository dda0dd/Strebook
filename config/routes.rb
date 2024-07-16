Rails.application.routes.draw do
  # devise_for :book_storesを下記に書き換え(devise_forの後に生成したコントローラがどこに存在するかの記述)
    # 書店(新規登録・ログイン)
  devise_for :book_stores, skip: [:passwords], controllers: {
    registrations: "book_store/registrations",
    sessions: 'book_store/sessions'
  }
  devise_scope :book_store do
    # ゲストログイン
      # guest/sessions_controller.rbのアクションに処理を繋げる
    get "book_stores/guest_sign_in", to: "guest/sessions#guest_sign_in"
  end
  #ログイン以外の機能
  namespace :book_store do
    # root :to =>"homes#top"
    # get '/about' => 'homes#about'
    # 退会機能のルーティング
    resources :book_stores, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    # ゲストログイン
    # devise_scope :customer do
      # guest/sessions_controller.rbのアクションに処理を繋げる
      # post "customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
    # end
    # 投稿機能(index, showがいるかも？)
    resources :posts do
      # キーワードでリクエストを検索する機能(searchはresourcesで作成されない)
      get 'search'
      # resources :comments, only: [:search] do
        # collection do
        # delete 'destroy_all'
        # end
      # end
      #タグ作成, 取得, 削除(管理者で削除できた方がいい？)createいらないかも？
      resources :tags, only: [:index, :create, :destroy]
        # collection do
        #   get 'thanks'
        # end
    end
    # リクエストコメント一覧
	  resources :request_comments, only: [:index]
  end

  # お客様(新規登録・ログイン)
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :customer do
    # ゲストログイン
      # guest/sessions_controller.rbのアクションに処理を繋げる
    get "customers/guest_sign_in", to: "guest/sessions#guest_sign_in"
  end
  #ログイン以外の機能
    root :to =>"homes#top"
    get '/about' => 'homes#about'
    namespace :public do
      # 退会機能のルーティング
      resources :customers, only: [:show, :edit, :update] do
        collection do
          get 'unsubscribe'
          patch 'withdraw'
        end
      end
      # 書店一覧表示, 書店マイページ表示
      resources :book_stores do
        # 感想コメント保存, 削除
        resources :thoughtse_comments, only: [:index, :create, :destroy]
        # 都道府県で書店を検索する機能(searchはresourcesで作成されない)
        get 'search'
        # resources :searches, only: [:search] do
          # collection do
          # delete 'destroy_all'
          # end
        # end
        # 書店の投稿にレビュー評価(:destroyいるかも？)
        resources :ratings, only: [:create]
          # collection do
          #   get 'thanks'
          # end
      end
      # 投稿一覧
      resources :posts, only: [:index]
      # リクエストコメント保存, 削除
      resources :request_comments, only: [:new, :index, :create, :destroy]
    end


   # skipオプションで不要ルーティングを削除(管理者登録：パスワード変更)
    # サイト管理者(ログイン)
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ログイン以外の機能
	  get '/' => 'homes#top'
  namespace :admin do
	 # 全てのレビュー閲覧, 削除ボタン設置
	  resources :reviews, only: [:index, :destroy]
	  #お客様詳細情報(管理者)
    resources :customers, only: [:index, :show, :destroy]
    # update追記(編集内容を更新できないので)
	  resources :comments, only: [:index, :show, :destroy]
	  #書店詳細情報(管理者)
	  resources :book_stores, only: [:index, :show, :destroy]
	 # 投稿一覧
	  resources :posts, only: [:index]
	 # リクエストコメント一覧
	  resources :request_comments, only: [:index]
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
end
