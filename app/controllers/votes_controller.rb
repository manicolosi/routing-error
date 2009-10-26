class VotesController < ApplicationController
  before_filter :require_user

  def create
    voteable_id   = params[:voteable_id]
    voteable_type = params[:voteable_type]
    voteable = voteable_type.constantize.find(voteable_id)
    direction = params[:commit].downcase.to_sym
    vote = Vote.vote(current_user, voteable, direction)

    unless vote.valid?
      flash[:error] = vote.errors.on(:voter) ||
      vote.errors.on(:voter_id)
    end

    redirect_to voteable
  end
end
