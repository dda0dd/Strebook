class Admin::CustomersController < ApplicationController
  # 権限の設定：ログインしていないユーザーが作業できないように設定
  before_action :authenticate_admin!

  def index
    @customers = Customer.all.page(params[:page]).per(5)
    # @book_stores = BookStore.all
    #管理者のお客様一覧記述
    #ページネーション対応に変更
    # @customers = Customer.page(params[:page])
    #管理者の書店一覧記述
    #ページネーション対応に変更
    # @book_stores = Book_store.page(params[:page])
  end

  def show
    # 会員(お客様)
    @customer = Customer.find(params[:id])
    # 会員(書店)
    # @book_store = BookStore.find(params[:id])
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

  def search
    # 検索フォームから情報を受け取る params[:range](検索モデル)
    # searches/search.htmlの"<%= @word %>"を定義
      @word = params[:is_active]
      # 検索フォームから情報を受け取るparams[:word](検索ワード)
        # pluck(:id)でIDだけ持ってくる
          # ("address LIKE?", "%#{@word}%")で部分一致検索
            # 下記はwhere変数で{}内にBookStoreの検索結果からpluck(:id)でbook_store_idだけを持ってくる
      if @word.present?
        # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
        @customers = Customer.where(is_active: @word).page(params[:page]).per(5)
      else
        # 検索結果にもページネーション反映させるため.page(params[:page]).per(5)追記
        @customers = Customer.all.page(params[:page]).per(5)
      end
      # where=Postの中(右の括弧内)を検索する
        # book_store_idでbook_store_idsを検索する
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
