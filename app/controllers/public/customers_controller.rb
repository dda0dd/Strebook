class Public::CustomersController < ApplicationController
  # 権限の設定：ログインしていないお客様が作業できないように設定
  before_action :authenticate_customer!
  # edit(編集)アクション実行前に処理を行う
  before_action :ensure_guest_customer, only: [:edit]

  def show
    # 現在ログインしているお客様
    @customer = current_customer
    # .page(params[:page]).per(9)でページネーション処理追記
      # .per(9)は表示される件数
    @request_comments = @customer.request_comments.page(params[:page]).per(5)
  end

  def edit
     @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "success"
      # リダイレクト先に会員(お客様)マイページ
      redirect_to public_customer_path(params[:id])
    else
      flash.now[:alert] = "failer"
      render :edit
    end
  end
  # unsubscribe.htmlのlink_toでcurrent_customerを記述しているのでcontrollerに記述不要
  def unsubscribe
  end

  def withdraw
    current_customer.update(is_active: false)
    reset_session
    #新規会員(お客様)登録画面に遷移
    redirect_to new_customer_registration_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name,
                                     :age,
                                     :address,
                                     :occupation,
                                     :email
                                     )
  end
  # 会員編集画面へのURLを直接入力時にメッセージ表示で会員詳細画面へリダイレクトさせる
  def ensure_guest_customer
    @customer = Customer.find(params[:id])
    # @customerはモデル名(ここでエラー時はcustomer.rbを見てみる)
    if @customer.guest?
      redirect_to customer_path(current_customer) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
