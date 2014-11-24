class SectionsController < ApplicationController
  before_action :set_section, only: [
    :show, :edit, :update,
    :destroy, :edit_pages
  ]
  respond_to :html

  def show
    if @section.pages.empty?
      respond_with(@section)
    else
      redirect_to @section.pages.first
    end
  end

  def edit
  end

  def edit_pages
  end

  def destroy
    @section.delete
    redirect_to edit_sections_course_path(@section.course)
  end

  def update
    @section.update(section_params)
    respond_with(@section)
  end

  private

  def set_section
    id = params[:id]
    @section = Section.find(id)
  end

  def section_params
    params.require(:section).permit(:name)
  end
end
