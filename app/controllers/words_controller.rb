class WordsController < ApplicationController
  before_action :check_logged
  def index
    @words = Word.paginate(page: params[:page],
      per_page: Settings.categories_per_page).order(created_at: "desc")
  end

  def new
    @word = Word.new
    @categories = Category.all
  end
end
