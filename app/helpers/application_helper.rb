module ApplicationHelper

  def corrected_user
    @user = User.find_by params[:id]
    redirect_to root_url unless current_user? @user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "page.usercontroller.loggeddanger"
      redirect_to login_url
    end
  end

end
