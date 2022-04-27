class UsersController < ApplicationController
  before_action :forbid_login_user, {only: [:name, :create, :login_form, :login]}
  before_action :ensure_current_user, {only: [:edit, :update]}


  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(book_params)
    flash[:notice] = 'You have updated user successfully'

    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end



  private

  def ensure_current_user
    @user = User.find(params[:id])
  if current_user.id != @user.id
    flash[:notice]="権限がありません"
    redirect_to user_path(current_user)
  end
  end

  def book_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
