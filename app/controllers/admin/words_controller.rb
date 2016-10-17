class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :required_admin
  before_action :load_categories, only: [:new, :create]

  def index
    @words = Word.paginate(page: params[:page],
      per_page: Settings.categories_per_page).sort_desc
  end

  def new
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

  private
  def word_params
    params.require(:word).permit :name, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_categories
    @categories = Category.all
  end
end
