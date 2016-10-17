class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :required_admin
  before_action :load_categories, only: [:new, :create]
  before_action :load_word, only: :destroy

  def index
    @words = Word.paginate(page: params[:page],
      per_page: Settings.categories_per_page).sort_desc
  end

  def new
    @categories = Category.all
    @word = Word.new
  end

  def create
    @word = Word.create word_params
    if @word.save
      flash[:success] = t "word.sucessful"
      redirect_to words_path
    else
      load_categories
      render :new
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "category.deletesuccess"
    else
      flash[:danger] = t "category.deleteerror"
    end
    redirect_to :back
  end
  
  private
  def word_params
    params.require(:word).permit :name, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_categories
    @categories = Category.all
  end

  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "word.nil"
      render file: "public/404.html", status: :not_found, layout: true
    end
  end

end
