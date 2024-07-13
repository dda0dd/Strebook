# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_status, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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

  protected

  def customer_status
      customer = Customer.find_by(name: params[:customer][:name])
      # 登録されていないnameの場合if文がtrueとなりreturnが実行される→ログインできず
      return if customer.nil?
      # nameとパスワードの組み合わせが正しくない場合unless文がtrueとなりreturnが実行される→ログインできず
      return unless customer.valid_password?(params[:customer][:password])
      # is_activeカラムがtrue場合if文がtrueとなりcustomer_stateメソッドが実行完了となり、createアクションが実行される＝ログインできる
      if customer.is_active == true
      # before_actionで定義しているからここでcreateの記述は不要かも
		    create
      else
         # ここまで来るのは退会した人（nameは登録済み＋パスワードも正しい、けどis_activeがfalse）→再登録のためにサインアップ画面へ→メールアドレスが登録済みの場合、同じアドレスで会員登録は出来ないはず
  	    redirect_to new_customer_registration_path
      end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
