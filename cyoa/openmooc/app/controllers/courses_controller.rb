class CoursesController < ApplicationController
  before_action :set_course, only: [
    :show, :edit, :update, :destroy,
    :edit_lessons
  ]
  respond_to :html

  def index
    @courses = Course.all
    respond_with(@courses)
  end

  def show
    respond_with(@course)
  end

  def query
    render :index
  end

  def new
    @course = Course.default
    respond_with(@course)
  end

  def edit
  end

  def edit_lessons
    respond_with(@course)
  end

  def create
    @course = Course.new(course_params)
    @course.save
    respond_with(@course)
  end

  def update
    @course.update(course_params)
    respond_with(@course)
  end

  private

  def set_course
    id = params[:id]
    @course = Course.find(id)
  end

  def course_params
    params.require(:course)
      .permit(:title, :subject, :topic, :description,
        page_content_attributes: [:content])
  end
end
