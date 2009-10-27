module UsersHelper
  def render_recent_activities(user)
    render :partial => 'recent_activity',
      :locals => { :recent_activity => user.recent_activity }
  end

  def activity_title(activity)
    send "#{activity.class.to_s.underscore}_title", activity
  end

  def activity_time(activity)
    "#{time_ago_in_words(activity.created_at)} ago"
  end

  def question_title(activity)
    "Asked &ldquo;#{activity.title}&rdquo;"
  end

  def answer_title(activity)
    "Answered &ldquo;#{activity.question.title}&rdquo;"
  end
end
