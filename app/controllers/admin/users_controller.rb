class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :required_admin, only: [:index]

  def index
    @users = User.paginate(page: params[:page],
      per_page: Settings.categories_per_page).order(created_at: "desc")
  end

end
