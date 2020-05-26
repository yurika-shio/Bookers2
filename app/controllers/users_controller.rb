class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @book = Book.new
  end

  def edit
     @user = User.find(params[:id])
  if @user != current_user
      redirect_to user_path(current_user.id)
  end
  end

  def show
  	@book = Book.new
  	@user = User.find(params[:id])
  	# @books = @user.books.page(params[:page]).reverse_order
    @books = @user.books
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'You have updated user successfully.'
      redirect_to user_path
    else
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.user_id = current_user.id
      @book.save
      redirect_to book_path
   else
        redirect_to book_path
   end
  end

  private 
def user_params
    params.require(:user).permit(:name, :profile_image)
end
end
