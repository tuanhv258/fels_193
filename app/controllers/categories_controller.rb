class CategoriesController < ApplicationController

  before_action :load_category, only: [:edit, :update, :destroy]
  before_action :check_logged

  def index
    @category = Category.new
    @categories = Category.paginate(page: params[:page],
      per_page: Settings.categories_per_page).sort_desc
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

  def destroy
    if @category.words.any?
      flash[:danger] = t "category.deleteerror"
      redirect_to :back
    else
      if @category.destroy
        flash[:success] = t "category.deletesuccess"
      else
        flash[:danger] = t "category.deleteerror"
      end
      redirect_to :back
    end
  end

  def update
    @category.update_attributes category_params
    if @category.save
      flash[:success] = t "page.usercontroller.updatesuccess"
      redirect_to :back
    else
      flash[:danger] = t "page.usercontroller.updatefail"
      redirect_to :back
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "user.nil"
      render file: "public/404.html", status: :not_found, layout: true
    end
  end

  def category_params
    params.require(:category).permit :title, :detail
  end

end
