class BooksController < ApplicationController
  before_action :ensure_current_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = 'You have created book successfully'
    redirect_to book_path(@book)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end


  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new

  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = 'You have updated book successfully'
    redirect_to book_path
    else
      render :edit
    end

  end


  private

  def ensure_current_user
    @book = Book.find(params[:id])
  if current_user.id != @book.user.id
    flash[:notice]="権限がありません"
    redirect_to books_path
  end
  end

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end
end
