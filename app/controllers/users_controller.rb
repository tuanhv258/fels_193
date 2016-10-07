class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page],
      per_page: Settings.categories_per_page).order(created_at: "desc")
  end

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

  def edit
    load_user
  end

  def update
    load_user
    if @user.update_attributes user_params
      flash[:success] = t "page.usercontroller.updatesuccess"
      redirect_to @user
    else
      flash[:danger] = t "page.usercontroller.danger"
      render :edit
    end
  end

  def destroy
    User.find_by(params[:id]).destroy
    flash[:success] = t "page.usercontroller.destroysuccess"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit :fullname, :email, :password, :password_confirmation
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

end
