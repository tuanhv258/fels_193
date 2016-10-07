class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  def load_user
    @user = User.find_by params[:id]
    if @user.nil?
      flash[:danger] = t "page.applicationcontroller.usernull"
      redirect_to root_path
    end
  end

  def required_admin
    unless current_user.is_admin?
      redirect_to users_path
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "page.applicationcontroller.please"
      redirect_to login_url
    end
  end

end
