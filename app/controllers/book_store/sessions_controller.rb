# frozen_string_literal: true

class BookStore::SessionsController < Devise::SessionsController
   before_action :book_store_status, only: [:create]
   #before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
	  root_path
  end

  def after_sign_out_path_for(resource)
	  root_path
  end

  def guest_sign_in
     # BookStore.guestのguestメソッドをbook_store.rbで定義
    book_store = BookStore.guest
    sign_in book_store
    # 遷移先にゲスト書店詳細(マイページ)指定
    redirect_to book_store_book_store_path(book_store.id), notice: "guestbook_storeでログインしました。"
  end

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end

  def book_store_status
    book_store = BookStore.find_by(name: params[:book_store][:name])
    # 登録されていないnameの場合if文がtrueとなりreturnが実行される→ログインできず
    return if book_store.nil?
    # nameとパスワードの組み合わせが正しくない場合unless文がtrueとなりreturnが実行される→ログインできず
    return unless book_store.valid_password?(params[:book_store][:password])
    # is_activeカラムがtrue場合if文がtrueとなりbook_store_stateメソッドが実行完了となり、createアクションが実行される＝ログインできる
    if book_store.is_active == true
      # before_actionで定義しているからここでcreateの記述は不要かも
		  create
    else
      # ここまで来るのは退会した書店（nameは登録済み＋パスワードも正しい、けどis_activeがfalse）→再登録のためにサインアップ画面へ→メールアドレスが登録済みの場合、同じアドレスで会員登録は出来ないはず
  	   redirect_to new_book_store_registration_path
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
