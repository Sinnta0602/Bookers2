class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit]

  def show
    # MEMO: deviseのヘルパーメソッド。ログインしてるユーザを表す。
    # ログインしてるユーザ == (ブラウザを操作してる)自分
    @user = current_user
    @book_user = User.find(params[:id])
    # user.booksっていうのは、Userモデルに描いた has_many :booksを書いたから
    @book = @book_user.books.new
    @books = @book_user.books
  end

  def edit
  end

  def index
    @user = current_user
    @book = @user.books.new
    @users = User.all
  end
end
