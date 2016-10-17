class WordsController < ApplicationController
  before_action :check_logged
  def index
    @words = Word.paginate(page: params[:page],
      per_page: Settings.categories_per_page).sort_desc
  end

end
