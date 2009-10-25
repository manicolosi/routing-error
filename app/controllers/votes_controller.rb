class VotesController < ApplicationController
  before_filter :require_user

  def create
    voteable = Question.find(params[:question_id])
    direction = params[:commit].downcase.to_sym
    vote = Vote.vote(current_user, voteable, direction)

    unless vote.valid?
      flash[:error] = "Dude, you've already voted!"
    end

    redirect_to voteable
  end
end
