class Guests::SessionsController < Devise::SessionsController
  def guest_sign_in
    # Customer.guestのguestメソッドをcustomer.rbで定義
    user = User.guest
    # ゲスト会員をログイン状態にする
    sign_in user
    # ログイン後ゲスト会員の詳細(マイページ)に遷移
    redirect_to user_path(user), notice: "guestcustomerでログインしました。"
  end
end