class VotesController < ApplicationController
  before_filter :require_user

  def create
    voteable_id   = params[:voteable_id]
    voteable_type = params[:voteable_type]
    voteable = voteable_type.constantize.find(voteable_id)
    direction = params[:commit].downcase.to_sym
    vote = Vote.vote(current_user, voteable, direction)

    unless vote.valid?
      flash[:error] = "Hey, you've already voted on this " +
                      "#{voteable_type.downcase}!"
    end

    redirect_to [voteable.parent, voteable]
  end
end
