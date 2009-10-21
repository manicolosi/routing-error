# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  private

  def flash_messages
    content_tag(:div, :id => 'flash_messages') do
      flash.collect do |key,msg|
        content_tag(:div, msg, :class => key)
      end
    end
  end

  def current_user_session
    return @current_user_session if defined? @current_user_session
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.user
  end

  def logged_in?
    current_user != nil
  end
end
