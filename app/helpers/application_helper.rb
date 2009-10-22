# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_messages
    content_tag(:div, :id => 'flash_messages') do
      flash.collect do |key,msg|
        content_tag(:div, msg, :class => key)
      end
    end
  end

  def author_link(item)
    link_to item.author.username, item.author
  end
end
