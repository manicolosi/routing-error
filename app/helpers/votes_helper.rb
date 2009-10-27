module VotesHelper
  def render_votes_for(voteable)
    @voteable = voteable
    @vote = current_user && current_user.vote_for(voteable)

    content_tag(:div, :class => 'vote') do
      vote_buttons + vote_score
    end
  end

  def vote_score
    content_tag(:strong, Vote.votes_score_for(@voteable), :class => 'score')
  end

  private

  def vote_buttons
    content_tag(:div, :class => 'vote-buttons') do
      [:up, :down].collect do |dir|
        image_tag(vote_image(dir), :class => vote_classes(dir),
          :title => vote_title(dir))
      end
    end.to_s
  end

  def vote_classes(dir)
    classes = ["vote-button vote-#{dir}"]
    classes << "voted" if vote_direction == dir
    classes.join(" ")
  end

  def vote_title(dir)
    if vote_direction == dir
      "Cancel this #{dir} vote"
    else
      "Vote this #{dir}"
    end
  end

  def vote_image(dir)
    vote_direction == dir ? "voted-#{dir}.png" : "vote-#{dir}.png"
  end

  def vote_direction
    return nil if @vote.nil?

    case @vote.value
      when 1: :up
      when -1: :down
      else raise "invalid vote value: #{vote.value.inspect}"
    end
  end
end
