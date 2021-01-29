class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit]

  def show
    # MEMO: deviseのヘルパーメソッド。ログインしてるユーザを表す。
    # ログインしてるユーザ == (ブラウザを操作してる)自分
    @book_user = User.find(params[:id])
    # user.booksっていうのは、Userモデルに描いた has_many :booksを書いたから
    @books = @book_user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])

    unless @user == current_user
      redirect_to user_path(current_user)
    end

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def index
    @user = current_user
    @book = @user.books.new
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
