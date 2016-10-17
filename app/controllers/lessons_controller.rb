class LessonsController < ApplicationController
  before_action :load_categories, only: :index
  before_action :load_lesson, :authorize_user_lesson, only: [:edit, :update, :show]

  def index
    @lesson = Lesson.new
    @lessons = current_user.lessons.order(created_at: :desc).
      paginate page: params[:page], per_page: Settings.per_page
  end

  def create
    @lesson = Lesson.new category_id: params[:lesson][:category_id],
      user_id: current_user.id
    if @lesson.save
      current_user.create_activity Activity.activity_types[:create_lesson],
        current_user.id
      flash[:success] = t "page.create_succse_and_join_lesson"
      redirect_to lessons_path @lesson
    else
      flash[:danger] = t "page.lesson_create_fail"
      redirect_to lessons_path
    end
  end

  private
  def load_categories
    @categories = Category.all
  end
end
