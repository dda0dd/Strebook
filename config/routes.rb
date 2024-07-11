Rails.application.routes.draw do
  # devise_for :book_storesを下記に書き換え(devise_forの後に生成したコントローラがどこに存在するかの記述)
    # 書店(新規登録・ログイン)
  devise_for :book_stores, skip: [:passwords], controllers: {
    registrations: "book_store/registrations",
    sessions: 'book_store/sessions'
  }
  #ログイン以外の機能
  scope module: :book_store do
    # root :to =>"homes#top"
    # get '/about' => 'homes#about'
    # ゲストログイン
    resources :guests, only: [:guest_login]
    # 退会機能のルーティング
    resources :book_stores, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    # 投稿機能(index, showがいるかも？)
    resources :posts, except: [:edit, :update, :create, :destroy] do
      # キーワードでリクエストを検索する機能(searchはresourcesで作成されない)
      get 'search'
      # resources :comments, only: [:search] do
        # collection do
        # delete 'destroy_all'
        # end
      # end
      #タグ作成, 取得, 削除(管理者で削除できた方がいい？)createいらないかも？
      resources :tags, except: [:index, :create, :destroy]
        # collection do
        #   get 'thanks'
        # end
    end
  end

  # お客様(新規登録・ログイン)
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #ログイン以外の機能
  scope module: :public do
    root :to =>"homes#top"
    get '/about' => 'homes#about'
    # ゲストログイン
    resources :guests, only: [:guest_login]
    # 退会機能のルーティング
    resources :customers, only: [:show, :edit, :update] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    # 書店一覧表示, 書店マイページ表示
    resources :book_stores, only: [:index, :show] do
      # リクエストコメント保存, 削除
      resources :request_comments, except: [:create, :destroy]
      # 感想コメント保存, 削除
      resources :thoughtse_comments, except: [:create, :destroy]
      # 都道府県で書店を検索する機能(searchはresourcesで作成されない)
      get 'search'
      # resources :searches, only: [:search] do
        # collection do
        # delete 'destroy_all'
        # end
      # end
      # 書店の投稿にレビュー評価(:destroyいるかも？)
      resources :ratings, except: [:create]
        # collection do
        #   get 'thanks'
        # end
    end
  end


   # skipオプションで不要ルーティングを削除(管理者登録：パスワード変更)
    # サイト管理者(ログイン)
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  #ログイン以外の機能
  namespace :admin do
	  get '/' => 'homes#top'
	 # 全てのレビュー閲覧, 削除ボタン設置
	  resources :reviews, except: [:index, :destroy]
	  #お客様詳細情報(管理者)
    resources :customers, only: [:index, :show, :edit, :update]
    # update追記(編集内容を更新できないので)
	  resources :comments, only: [:index, :show, :edit, :update, :destroy]
	  #書店詳細情報(管理者)
	  resources :book_stores, only: [:index, :show, :edit, :update]
	end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.htm
end
