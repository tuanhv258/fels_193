class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.hello"
      redirect_to root_path
    else
      flash[:danger] = t "user.danger"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user.nil"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :password, :password_confirmation
  end
end
