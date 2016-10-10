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

  def gravatar_for user, size: Settings.size
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url =
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.fullname,
      class: "gravatar img-circle img-center")
  end

end
