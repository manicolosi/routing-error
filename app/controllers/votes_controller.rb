class VotesController < ApplicationController
  before_filter :require_user

  def create
    @question = Question.find(params[:question_id])
    direction = params[:commit].downcase.to_sym
    @question.vote(direction)

    redirect_to @question
  end
end
