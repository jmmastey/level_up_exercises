class FillInTheBlankQuestionsController < ApplicationController
  before_action :set_section, only: [:new, :create_for_section]
  before_action :set_quiz_activity, only: [:new, :update_for_quiz_activity]
  before_action :set_question, only: [:submit_answer, :edit, :update, :find_aliases, :create_answers]
  before_action :set_answer_submission, only: [:submit_answer]

  def new
    @question = FillInTheBlankQuestion.new(page_content: PageContent.new)
  end

  def edit
  end

  def find_aliases
    @aliases = Alias.query(params[:q])
  end

  def create_for_section
    @question = FillInTheBlankQuestion.new(question_params)
    @question.quiz_activity = QuizActivity.create(section: @section)
    @question.save
    redirect_to @question.page
  end

  def update_for_quiz_activity
    old_question = @quiz_activity.question.destroy
    if @quiz_activity.update!(question: FillInTheBlankQuestion.new(question_params))
      old_question.destroy
    end
    redirect_to @quiz_activity.page
  end

  def create_answers
    answers = answers_from_aliases
    @question.update(answers: @question.answers + answers)
    redirect_to edit_quiz_activity_path(@question.quiz_activity)
  end

  def create
    @question = FillInTheBlankQuestion.new(question_params)
    @question.save
    redirect_to @question.quiz_activity.page
  end

  def update
    activity = @question.quiz_activity
    @question.update(question_params)
    redirect_to @question.quiz_activity.page
  end

  def submit_answer
    if @question.correct_answer?(@answer_submission)
      correct_response
    else
      incorrect_response
    end
  end

  private

  def answers_from_aliases
    answers = aliases_params.keep_if { |a| a['add'] == '1' }
    answers.map! { |a| FillInTheBlankAnswer.from_alias(a) }
  end

  def aliases_params
    params.permit(aliases: [:add, :text]).require(:aliases)
  end

  def correct_response
    flash[:success] = 'Great Job!'
    redirect_to @question.quiz_activity.page.decorate.next_link[:path]
  end

  def incorrect_response
    flash[:danger] =
      "Incorrect response '#{@answer_submission}'"
    redirect_to @question.quiz_activity.page
  end

  def set_question
    id = params[:id]
    @question = FillInTheBlankQuestion.find(id)
  end

  def set_section
    id = params.require(:fill_in_the_blank_question)[:section_id]
    @section = Section.find(id)
  end

  def set_quiz_activity
    id = params.require(:fill_in_the_blank_question)[:quiz_activity_id]
    @quiz_activity = QuizActivity.find(id)
  end

  def set_answer_submission
    @answer_submission = params[:answer]
  end

  def question_params
    params.require(:fill_in_the_blank_question)
      .permit(
        answers_attributes: [:id, :text, :_destroy],
        page_content_attributes: [:content],
      )
  end
end
