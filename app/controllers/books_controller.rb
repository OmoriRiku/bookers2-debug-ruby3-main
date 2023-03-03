class BooksController < ApplicationController
  before_action :ensure_book_user, only: [:edit, :update]

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    index_sort
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  
  def index_sort
    if params[:id]
      @books = Book.order(id: :desc)
    elsif params[:star]
      @books = Book.order(star: :desc)
    else
      @books = Book.all
    end
  end

  def ensure_book_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def book_params
    params.require(:book).permit(:title,:body, :star)
  end
end
