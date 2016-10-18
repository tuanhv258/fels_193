class WordsController < ApplicationController
  before_action :check_logged
  before_action :load_word, only: [:destroy, :update, :edit]
  before_action :load_category

  def index
    params[:search] ||= ""
    params[:word_filter] ||= Settings.word_filter[:all]
    @words = Word.in_category(params[:category_id])
      .send(params[:word_filter], current_user.id, params[:search])
      .paginate page: params[:page], per_page: Settings.categories_per_page
  end

  private
  def load_category
    @categories = Category.all
  end
end
