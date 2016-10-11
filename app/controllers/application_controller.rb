class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "user.nil"
      render file: "public/404.html", status: :not_found, layout: true
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

  def check_logged
    unless logged_in?
      redirect_to root_path
    end
  end

end
