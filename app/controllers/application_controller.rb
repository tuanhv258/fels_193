class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  def load_user
    @user = User.find_by params[:id]
  end

end
