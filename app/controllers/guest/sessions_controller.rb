class Guest::SessionsController < Devise::SessionsController
  def guest_sign_in
    # Customer.guestのguestメソッドをcustomer.rbで定義
    customer = Customer.guest
    # BookStore.guestのguestメソッドをbook_store.rbで定義
    book_store = BookStore.guest
    # ゲスト会員をログイン状態にする
    sign_in customer
    sign_in book_store
    # ログイン後ゲスト会員の詳細(マイページ)に遷移
    redirect_to customer_path(customer), notice: "guestcustomerでログインしました。"
    redirect_to book_store_path(book_store), notice: "guestbook_storeでログインしました。"
  end
end