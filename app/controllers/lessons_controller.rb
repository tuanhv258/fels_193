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

  def update
    @lesson.is_complete = true
    @lesson.update_attributes lesson_params
    current_user.create_activity Activity.activity_types[:finished],
      current_user.id
    redirect_to lesson_path @lesson
  end

  def edit
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "lesson_not_found"
    end
  end

  def lesson_params
    params.require(:lesson).permit :is_complete, results_attributes: [:id, :answer_id]
  end

  def authorize_user_lesson
    unless current_user.current_user? @lesson.user
      flash[:danger] =  t "authorize_user_lesson_err"
      redirect_to root_url
    end
  end

  private
  def load_categories
    @categories = Category.all
  end
end
