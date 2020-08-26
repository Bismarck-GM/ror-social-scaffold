class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :validate_friend
  validates :user_id, uniqueness: { scope: :friend_id, message: 'You\'ve already sent a friend request to this person' }

  def validate_friend
    errors.add(' ', "You can't request yourself as a friend. Being lonely is not an excuse") if user_id == friend_id
  end

  def confirm_friend
    update accepted: true
    Friendship.create!(user_id: friend_id, friend_id: user_id, accepted: true)
  end
end
