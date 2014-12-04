class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :move_higher, :move_lower]
  respond_to :html

  def show
  end

  def edit
  end

  def move_higher
    @page.move_higher
    redirect_to edit_pages_lesson_path(@page.lesson)
  end

  def move_lower
    @page.move_lower
    redirect_to edit_pages_lesson_path(@page.lesson)
  end

  private

  def set_page
    id = params[:id]
    @page = Page.find(id)
  end
end
