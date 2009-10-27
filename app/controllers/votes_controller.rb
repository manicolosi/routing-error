class VotesController < ApplicationController
  before_filter :require_user

  def create
    voteable_id   = params[:voteable_id]
    voteable_type = params[:voteable_type]
    voteable = voteable_type.classify.constantize.find(voteable_id)
    direction = params[:direction].to_sym
    vote = Vote.vote(current_user, voteable, direction)
    @vote = vote

    unless vote.valid?
      flash[:error] = []
      vote.errors.each do |attr, mesg|
        flash[:error] << "#{mesg}"
      end
    end

    redirect_to voteable
  end

  def destroy
    vote = current_user.votes.find(params[:id])
    voteable = vote.voteable

    vote.destroy

    redirect_to voteable
  end
end
