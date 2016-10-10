class CategoriesController < ApplicationController
  before_action :check_logged
  def index
    @categories = Category.paginate(page: params[:page],
      per_page: Settings.categories_per_page).order(created_at: "desc")
  end
end
