module UsersHelper
  def render_activity_for(activity)
    subdir = activity.class.to_s.downcase.pluralize # Yuck!
    partial = "#{subdir}/profile_activity"
    render :partial => partial, :locals => { :activity => activity }
  end
end
