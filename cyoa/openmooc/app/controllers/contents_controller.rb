class ContentsController < ApplicationController
  before_action :set_lesson, only: [:new, :create]
  before_action :set_content, only: [:edit, :update]
  respond_to :html

  def new
    @content = Content.default
    @content.lesson = @lesson
  end

  def edit
  end

  def create
    @page = Page.create(
      lesson: @lesson,
      content: Content.new(content_params),
    )
    redirect_to page_path(@page)
  end

  def update
    @content.update(content_params)
    redirect_to page_path(@content.page)
  end

  private

  def set_lesson
    id = params[:lesson_id] || params[:content][:lesson_id]
    @lesson = Lesson.find(id)
  end

  def set_content
    id = params[:id]
    @content = Content.find(id)
  end

  def content_params
    params.require(:content).permit(
      :page_id, page_content_attributes: [:content]
    )
  end
end
