class VotesController < ApplicationController
  before_filter :require_user

  def create
    question = Question.find(params[:question_id])
    direction = params[:commit].downcase.to_sym
    vote = question.vote(current_user, direction)

    unless vote.valid?
      flash[:error] = "Dude, you've already voted!"
    end

    redirect_to question
  end
end
