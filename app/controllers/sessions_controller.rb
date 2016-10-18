class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      flash[:success] = t "page.sessioncontroller.success"
      user.is_admin? ? (redirect_to categories_path) : (redirect_to lessons_path)
    else
      flash[:danger] = t "page.sessioncontroller.danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
