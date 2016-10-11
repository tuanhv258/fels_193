class CategoriesController < ApplicationController
  before_action :load_category, only: [:edit, :update]
  before_action :check_logged

  def new
    @categories = Category.all
    @word = Word.new
  end
  def index
    @category = Category.new
    @categories = Category.paginate(page: params[:page],
      per_page: Settings.categories_per_page).order(created_at: "desc")
  end

  def destroy
    @categories = Category.find_by id: params[:id].destroy
    unless @categories
      flash[:danger] = t "category.deleteerror"
      redirect_to :back
    else
      flash[:success] = t "category.deletesuccess"
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
