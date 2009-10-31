class FriendshipsController < ApplicationController
  before_filter :require_user

  def create
    friend = User.find(params[:friend_id])
    friendship = current_user.friendships.create(:friend => friend)

    unless friendship.valid?
      flash[:error] = "Could not befriend #{friend.username}"
    end

    redirect_to friend
  end

  def destroy
    friendship = current_user.friendships.find(params[:id])
    friend = friendship.friend
    friendship.destroy

    redirect_to friend
  end
end
