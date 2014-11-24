class QuizActivitiesController < ApplicationController
  before_action :set_section, only: [
    :new, :create, :fill_in_the_blank_question,
    :multiple_choice_question
  ]
  before_action :set_quiz_activity, only: [
    :edit, :update_fill_in_the_blank_question,
    :update_multiple_choice_question
  ]
  respond_to :html

  def new
    @quiz_activity = default_quiz_activity
  end

  def update_fill_in_the_blank_question
    @quiz_activity.question = FillInTheBlankQuestion.new
    render 'update_question'
  end

  def update_multiple_choice_question
    @quiz_activity.question = MultipleChoiceQuestion.new
    render 'update_question'
  end

  def fill_in_the_blank_question
    @quiz_activity = quiz_activity_for(FillInTheBlankQuestion.new)
    render 'new'
  end

  def multiple_choice_question
    @quiz_activity = quiz_activity_for(MultipleChoiceQuestion.new)
    render 'new'
  end

  def create
    @quiz_activity = QuizActivity.new(quiz_activity_params)
    @quiz_activity.create(section: @section)
    redirect_to @quiz_activity.page
  end

  def edit
  end

  private

  def default_quiz_activity
    quiz_activity_for(FillInTheBlankQuestion.new)
  end

  def quiz_activity_for(question)
    QuizActivity.new(
      section: @section,
      question: question
    )
  end

  def set_quiz_activity
    id = params[:id]
    @quiz_activity = QuizActivity.find(id)
  end

  def set_section
    id = params[:id]
    @section = Section.find(id)
    fail 'need section' if @section.nil?
  end

  def quiz_activity_params
    params.require(:quiz_activity)
      .permit(:questions, :answers)
  end
end
