class Public::CustomersController < ApplicationController
  # 権限の設定：ログインしていないお客様が作業できないように設定
  before_action :authenticate_customer!


  def show
    # 現在ログインしているお客様
    @customer = current_customer
  end

  def edit
     @customer = current_customer
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    # リダイレクト先に会員(お客様)マイページ
    redirect_to customer_path(params[:id])
  end
  # unsubscribe.htmlのlink_toでcurrent_customerを記述しているのでcontrollerに記述不要
  def unsubscribe
  end

  def withdraw
    current_customer.update(is_active: false)
    reset_session
    #新規会員(お客様)登録画面に遷移
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name,
                                     :age,
                                     :address,
                                     :occupation
                                     )
  end
end
