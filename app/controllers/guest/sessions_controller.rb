class Guests::SessionsController < Devise::SessionsController
  def guest_sign_in
    # Customer.guestのguestメソッドをcustomer.rbで定義
    customer = Customer.guest
    # ゲスト会員をログイン状態にする
    sign_in customer
    # ログイン後ゲスト会員の詳細(マイページ)に遷移
    redirect_to customer_path(customer), notice: "guestcustomerでログインしました。"
  end
end