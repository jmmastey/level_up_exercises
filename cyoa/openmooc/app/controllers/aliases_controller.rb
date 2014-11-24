class AliasesController < ApplicationController
  before_action :set_question, only: [ :find ]


  def find
    @aliases = Alias.query(params[:q])
  end

  private

  def set_question
    @question = FillInTheBlankQuestion.find(params[:id])
  end
end
