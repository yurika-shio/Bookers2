class BooksController < ApplicationController
    before_action :authenticate_user!
	def update
        @book = Book.find(params[:id])
    if @book.update(book_params)
        flash[:success] = 'Book was successfully updated.'
        redirect_to book_path
    else
        render :edit
    end
    end

    def edit
        @book = Book.find(params[:id])
    if @book.user_id != current_user.id
        redirect_to books_path
    end
    end

    def create
    	@book = Book.new(book_params)
        @book.user_id = current_user.id
     if @book.save
        flash[:success] = 'You have creatad book successfully.'
    	redirect_to book_path(@book.id)
     else
        @books = Book.all
        render :index
     end
    end
    
    def destroy
        @book = Book.find(params[:id])
      if @book.destroy
        flash[:success] = 'Book was successfully destroyed.'
        redirect_to books_path
      end
    end

    def top
    end

	def index
    	@book = Book.new
    	@books = Book.all
    end
    
	def show
        @book_new = Book.new
    	@book = Book.find(params[:id])
        @book_comment = BookComment.new
        @user = @book.user
    end
    private
    def book_params
        params.require(:book).permit(:title, :body)
    end
end
