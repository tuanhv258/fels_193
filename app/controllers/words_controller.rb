class WordsController < ApplicationController
  before_action :check_logged
  before_action :load_word, only: [:destroy, :update, :edit]
  before_action :load_category

  def index
    @words = Word.paginate(page: params[:page],
      per_page: Settings.categories_per_page).sort_desc
  end

  private
  def load_category
    @categories = Category.all
  end
end
