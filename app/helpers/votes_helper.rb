module VotesHelper
  def render_votes_form(voteable)
    render :partial => 'votes/form', :locals => { :voteable => voteable }
  end

  # HACK: The rest of these methods depend on this method being called
  # first.
  def vote_form_url(voteable)
    @voteable = voteable
    current_user_voted? ? "/votes/#{current_user_vote.id}" : "/votes"
  end

  def vote_fields
    html = []
    html << hidden_field_tag('voteable_id', @voteable.id, :id => nil)
    html << hidden_field_tag('voteable_type', @voteable.class, :id => nil)
    html << vote_up_tag
    html << vote_down_tag
    html.join("\n")
  end

  def current_user_vote
    current_user && current_user.vote_for(@voteable)
  end

  def current_user_voted?
    current_user_vote != nil
  end

  def vote_form_method
    current_user_voted? ? :delete : :post
  end

  def vote_up_tag
    if current_user_voted? && current_user_vote.value == -1
      submit_tag "Up", :disabled => true, :id => nil
    elsif current_user_voted? && current_user_vote.value == 1
      submit_tag "Up", :id => nil, :class => 'voted'
    else
      submit_tag "Up", :id => nil
    end
  end

  def vote_down_tag
    if current_user_voted? && current_user_vote.value == 1
      submit_tag "Down", :disabled => true, :id => nil
    elsif current_user_voted? && current_user_vote.value == -1
      submit_tag "Down", :id => nil, :class => 'voted'
    else
      submit_tag "Down", :id => nil
    end
  end
end
