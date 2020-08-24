module UsersHelper
  def show_invite_to_friendship(user)
    if current_user.is_friend?(user, true) || current_user.id == user.id
      return nil
    elsif current_user.is_friend?(user, false)
      link_to 'Cancel friend request',  user_friendships_cancel_path(user), method: :post, class: 'profile-link'
    else current_user.is_friend?(user)
      link_to 'Invite to Friendship',  user_friendships_path(user), method: :post, class: 'profile-link'
    end
  end
end
