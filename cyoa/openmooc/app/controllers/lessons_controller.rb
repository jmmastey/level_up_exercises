class LessonsController < ApplicationController
  before_action :set_lesson, only: [
    :show, :edit, :update,
    :destroy, :edit_pages
  ]
  respond_to :html

  def show
    if @lesson.pages.empty?
      respond_with(@lesson)
    else
      redirect_to @lesson.pages.first
    end
  end

  def create
    @course = Lesson.create(lesson_params)
    respond_with(@course)
  end

  def edit
  end

  def edit_pages
  end

  def destroy
    @lesson.delete
    redirect_to edit_lessons_course_path(@lesson.course)
  end

  def update
    @lesson.update(lesson_params)
    respond_with(@lesson)
  end

  private

  def set_lesson
    id = params[:id]
    @lesson = Lesson.find(id)
  end

  def lesson_params
    params.require(:lesson).permit(:name, :course_id)
  end
end
