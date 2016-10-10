class CategoriesController < ApplicationController
  before_action :check_logged

  def index
    @categories = Category.paginate(page: params[:page],
      per_page: Settings.categories_per_page).order(created_at: "desc")
  end

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new category_params
    if @categories.save
      flash[:success] = t "page.categoriescontroller.createsuccess"
      redirect_to categories_path
    else
      flash[:danger] = t "page.categoriescontroller.createdanger"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :title, :detail
  end

end
