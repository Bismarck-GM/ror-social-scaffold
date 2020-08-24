class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = current_user.received_friend_requests
  end

  def create
    request = current_user.friendships.build(friend_id: params[:user_id], accepted: false)

    if request.save
      redirect_to users_path, notice: 'Friend request was sent successfully.'
    else
      redirect_to users_path, alert: request.errors.full_messages.join(', ')
    end
  end

  def accept
    friendship = current_user.reverse_friendships.find_by!(user_id: params[:user_id])
    friendship.update accepted: true
    redirect_to friendships_path, notice: 'Friendship accepted successfully.'
  end

  def reject
    friendship = current_user.reverse_friendships.find_by!(user_id: params[:user_id])
    friendship.destroy
    redirect_to friendships_path, notice: 'Friendship rejected successfully.'
  end
end