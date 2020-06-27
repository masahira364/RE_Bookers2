class BooksController < ApplicationController
	before_action :correct_user, only: [:edit, :update]

  def index
  	@books = Book.all
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  	redirect_to book_path(@book), notice: 'You have creatad book successfully.'
  	else
  		@books = Book.all
  		render :index
  	end
  end

  def show
  	@book = Book.find(params[:id])
  	@book_new = Book.new
  	@user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	@book.update(book_params)
  	if @book.save
  		redirect_to book_path(@book), notice: 'You have updated book successfully'
  	else
  		render :edit
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: 'You have destroy successfully.'
  end

  def correct_user
  	@book = current_user.books.find_by(id: params[:id])
  	unless @book
  		redirect_to books_path
  	end
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body)
  end
end
