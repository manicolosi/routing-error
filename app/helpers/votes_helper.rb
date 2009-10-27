module VotesHelper
  def render_votes_for(voteable)
    @voteable = voteable
    @vote = current_user && current_user.vote_for(voteable)

    content_tag(:div, :class => 'vote') do
      inner_html = ""
      inner_html << (@vote ?  render_vote_cancel : render_vote_form)
      inner_html << vote_score
    end
  end

  def vote_score
    content_tag(:strong, Vote.votes_score_for(@voteable), :class => 'score')
  end

  private

  def render_vote_form
    render :partial => 'votes/form', :locals => { :voteable => @voteable }
  end

  def render_vote_cancel
    link_to(vote_image(:up) + vote_image(:down), @vote,
      :method => :delete, :title => "Cancel #{vote_direction} vote")
  end

  def vote_image(dir)
    image_tag (vote_direction == dir) ? "voted-#{dir}.png" : "vote-#{dir}.png"
  end

  def vote_direction
    case @vote.value
      when 1: :up
      when -1: :down
      else raise "invalid vote value: #{vote.value.inspect}"
    end
  end
end
