Rails.application.routes.draw do
  # devise_for :book_storesを下記に書き換え(devise_forの後に生成したコントローラがどこに存在するかの記述)
    # top
    root :to =>"homes#top"
    # about
    get '/about' => 'homes#about'
    # 書店(新規登録・ログイン)
  devise_for :book_stores, skip: [:passwords], controllers: {
    # 新規会員登録
    registrations: "book_store/registrations",
    # ログイン
    sessions: 'book_store/sessions'
  }
  # 書店
  devise_scope :book_store do
    # ゲストログイン
      # guest/sessions_controller.rbのアクションに処理を繋げる
    get "book_stores/guest_sign_in", to: "book_store/sessions#guest_sign_in"
  end
  #ログイン以外の機能
  namespace :book_store do
  
    resources :book_stores, only: [:show, :edit, :update] do
      # 書店投稿
      resources :posts do
        # 特定の投稿に紐づく感想コメント一覧
        resources :comments, only: [:index]
      end
      #タグ作成, 取得, 削除(管理者で削除できた方がいい？)createいらないかも？
      resources :tags, only: [:index, :create, :destroy]
      collection do
        # 退会
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    # 投稿機能(index, showがいるかも？)
    resources :posts
    # リクエストコメント一覧
	  resources :request_comments, only: [:index] do
      # キーワードでリクエストを検索する機能(searchはresourcesで作成されない)
      collection do
        # 検索機能
        get 'search'
      end
	  end
  end

  # お客様(新規登録・ログイン)
  devise_for :customers, skip: [:passwords], controllers: {
    # 新規会員登録
    registrations: "public/registrations",
    # ログイン
    sessions: 'public/sessions'
  }
  # お客様
  devise_scope :customer do
    # ゲストログイン
      # guest/sessions_controller.rbのアクションに処理を繋げる
    get "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
    #ログイン以外の機能
    namespace :public do
      resources :customers, only: [:show, :edit, :update] do
        collection do
          # 退会
          get 'unsubscribe'
          patch 'withdraw'
        end
      end
      # 書店一覧表示, 書店マイページ表示
      resources :book_stores 
      # 投稿一覧
      resources :posts, only: [:index, :show] do
        # 感想コメント保存, 削除
        resources :thoughtse_comments, only: [:index, :create, :destroy]
        # お客様の書店投稿一覧で都道府県検索(書店を)窓設置
          # collection=do~end内をID含まないものとして指定できる
          collection do
            # 検索
            get 'search'
          end
      end
      # リクエストコメント保存, 削除
      resources :request_comments, only: [:new, :index, :create, :destroy]
    end
    
  # skipオプションで不要ルーティングを削除(管理者登録：パスワード変更)
    # サイト管理者(ログイン)
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ログイン以外の機能
  namespace :admin do
	  #お客様詳細情報(管理者)
    resources :customers, only: [:index, :show, :destroy] do
      # お客様一覧で有効か退会かの検索窓設置
        # adminでお客様を退会できるように追記
      member do
        get 'unsubscribe'
        patch 'withdraw'
      end
      collection do
        get 'search'
      end
    end
    # update追記(編集内容を更新できないので)
	  resources :comments, only: [:index, :show, :destroy] do
	   # 投稿に紐づく感想コメント一覧で不適切なワード検索窓設置
	   collection do
      get 'search'
	   end
	  end
	  #書店詳細情報(管理者)
	  resources :book_stores, only: [:index, :show, :destroy] do
	   # 書店一覧で有効か退会かの検索窓を設置
	   # adminで書店を退会できるように追記
	   member do
	    get 'unsubscribe'
      patch 'withdraw'
    end
	   collection do
	    get 'search'
	   end
	  end
	 # 投稿一覧
	  resources :posts, only: [:index, :destroy] do
	   # 書店投稿一覧で不適切なワード検索窓を設置
	   collection do
	     get 'search'
	   end
	  end
	 # リクエストコメント一覧
	  resources :request_comments, only: [:index, :destroy] do
	   # リクエストコメント一覧で不適切なワード検索窓を設置
	   collection do
	     get 'search'
	   end
	  end
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
end
