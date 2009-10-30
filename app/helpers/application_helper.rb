# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def author_link(item)
    link_to item.author.username, item.author
  end

  def flash_messages
    content_tag(:div, :id => 'flash_messages') do
      flash.collect do |key,mesg|
        if flash[key].respond_to? :each
          flash[key].collect { |mesg| flash_div(key, mesg) }
        else
          flash_div(key, mesg)
        end
      end
    end
  end

  private

  def flash_div(key, mesg)
    content_tag(:div, mesg, :class => ["flash_message", key].join(" "))
  end
end
