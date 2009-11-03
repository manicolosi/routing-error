class VotesController < ApplicationController
  before_filter :require_user

  def create
    voteable_id   = params[:voteable_id]
    voteable_type = params[:voteable_type]
    voteable = voteable_type.constantize.find(voteable_id)
    direction = params[:commit].downcase.to_sym
    @vote = Vote.vote(current_user, voteable, direction)

    unless @vote.valid?
      flash[:error] = []
      @vote.errors.each do |attr, mesg|
        flash[:error] << mesg
      end
    end

    respond_to do |format|
      format.html { redirect_to voteable }
      format.js
    end
  end

  def destroy
    vote = current_user.votes.find(params[:id])
    voteable = vote.voteable

    vote.destroy

    redirect_to voteable
  end
end
