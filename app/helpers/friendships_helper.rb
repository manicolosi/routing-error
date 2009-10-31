module FriendshipsHelper
  def render_follow_buttons(user)
    return if !logged_in? || current_user == user

    friendship = current_user.friendships.find_by_friend_id(user.id)

    render :partial => "friendships/form", :locals => {
      :path   => form_path(friendship),
      :method => friendship ? :delete : :post,
      :friend_id => user.id,
      :button_text => friendship ? "Unfollow" : "Follow",
    }
  end

  private

  def form_path(friendship)
    if friendship
      [current_user, friendship]
    else
      user_friendships_path(current_user)
    end
  end
end
