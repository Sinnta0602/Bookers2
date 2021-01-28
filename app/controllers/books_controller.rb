class BooksController < ApplicationController
  # MEMO: deviseのヘルパーメソッドの一つ。
  # ログインしてなかったら、ログインページに移動させてくれる。
  before_action :authenticate_user!, only: [:index, :show, :edit]

  def about
  end

  def top
  end

  def index
    @user = current_user.id
    @book = current_user.books.new(book_params)
    @books = Book.all
  end

  def show
    @book = current_user.books.new(book_params)
    @find_book = Book.find(params[:id])
  end

  def create
    # MEMO: current_userはdeviseのヘルパーメソッド。
    # アソシエーションを使って、user.booksを定義。
    @book = current_user.books.new(book_params)

    # MEMO: 保存に成功したら、bookのshowページにリダイレクト
    if @book.save
      redirect_to book_path(@book)
    # MEMO: エラーが発生した時、「自分のアクションに」bookのindexページを呼び込む
    # なので、indexページに必要なインスタンス変数を定義し直さないといけない。
    # 今回、これは@userとか、@booksとか。
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  private

  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end