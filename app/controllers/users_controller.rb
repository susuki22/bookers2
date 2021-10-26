class UsersController < ApplicationController
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to user_path(@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render action: :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
