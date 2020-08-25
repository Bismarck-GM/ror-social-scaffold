module UsersHelper
  def show_invite_to_friendship(user)
    if current_user.friend?(user, true) || current_user.id == user.id
      nil
    elsif current_user.friend?(user, false)
      link_to 'Cancel friend request', user_friendships_cancel_path(user), method: :post, class: 'profile-link'
    else
      link_to 'Invite to Friendship', user_friendships_path(user), method: :post, class: 'profile-link'
    end
  end
end
