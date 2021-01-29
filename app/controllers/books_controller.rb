class BooksController < ApplicationController
  # MEMO: deviseのヘルパーメソッドの一つ。
  # ログインしてなかったら、ログインページに移動させてくれる。
  before_action :authenticate_user!, only: [:index, :show, :edit]

  def about
  end

  def top
  end

  def index
    @user = current_user
    @book = current_user.books.new
    @books = Book.all
  end

  def show
    @user = current_user
    # MEMO: アソシエーションで user.books
    @book = current_user.books.new
    @find_book = Book.find(params[:id])
    # MEMO: アソシエーションで book.user
    @book_user = @find_book.user
  end

  def create
    # MEMO: current_userはdeviseのヘルパーメソッド。
    # アソシエーションを使って、user.booksを定義。
    @book = current_user.books.new(book_params)

    # MEMO: 保存に成功したら、bookのshowページにリダイレクト
    if @book.save
      flash[:notice] = "You have created book successfully."
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

  def edit
    @book = Book.find(params[:id])

    unless @book.user == current_user
      redirect_to books_path
    end
    
    @user = current_user
  end

  def update
    @book = Book.find(params[:id])
    
    unless @book.user == current_user
      redirect_to books_path
    end
    
    @user = current_user
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end