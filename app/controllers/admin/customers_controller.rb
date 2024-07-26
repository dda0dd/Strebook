class Admin::CustomersController < ApplicationController
  # 権限の設定：ログインしていないユーザーが作業できないように設定
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(5)
  end

  def show
    # 会員(お客様)
    @customer = Customer.find(params[:id])
  end

  def edit
    #該当する会員(お客様)を見つけて編集する
    @customer = Customer.find(params[:id])
    #該当する会員(書店)を見つけて編集する
    @book_store = Book_store.find(params[:id])
  end

  def update
    # 会員(お客様)
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました。"
    else
      render :edit
    end
    # 会員(書店)
    @book_store = Book_store.find(params[:id])
    if @book_store.update(book_store_params)
      redirect_to admin_book_store_path(@book_store), notice: "会員情報を更新しました。"
    else
      render :edit
    end
  end

  def unsubscribe
     @customer = Customer.find(params[:id])
  end

  def withdraw
    customer = Customer.find(params[:id])
    customer.update(is_active: false)
    #管理者のお客様一覧画面に遷移
    redirect_to admin_customers_path
  end

  def search
    # 検索フォームから情報を受け取る params[:word](検索モデル)
    @word = params[:is_active]
    if @word.present?
      # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
      @customers = Customer.where(is_active: @word).page(params[:page]).per(5)
    else
      # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
      @customers = Customer.all.page(params[:page]).per(5)
    end
    # 検索後に検索結果を下記ページに表示(検索後の遷移先)
    render "admin/customers/index"
  end

  private
  #安全に更新できる属性のみを送信する
    # 会員(お客様)
  def customer_params
    params.require(:customer).permit(:name, :age, :address, :occupation, :is_active)
  end
  # 会員(書店)
  def book_store_params
    params.require(:book_store).permit(:name, :age, :address, :telephone_number, :is_active)
  end
end
