class VotesController < ApplicationController
  before_filter :require_user, :find_voteable

  def create
    direction = params[:commit].downcase.to_sym
    vote = Vote.vote(current_user, @voteable, direction)

    unless vote.valid?
      flash[:error] = "Dude, you've already voted on this #@voteable_type!"
    end

    redirect_to [ @voteable_parent, @voteable ]
  end

  private

  def find_voteable
    @voteable_type = params[:answer_id] ? 'answer' : 'question'
    @voteable_id = params["#{@voteable_type}_id"]
    @voteable = @voteable_type.classify.constantize.find(@voteable_id)
    @voteable_parent = @voteable_type == 'answer' ? @voteable.question : nil
  end
end
