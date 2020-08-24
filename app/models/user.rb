class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :reverse_friendships, foreign_key: :friend_id, class_name: Friendship.name
  has_many :friends,
           -> { where(friendships: { accepted: true }) },
           through: :friendships,
           source: :user
  has_many :received_friend_requests,
           -> { where(friendships: { accepted: false }) },
           through: :reverse_friendships,
           source: :user
  has_many :sent_friend_requests,
           -> { where(friendships: { accepted: false }) },
           through: :friendships,
           source: :user

  def is_friend?(user, accepted=true)
    !friendships.find do |friendship| 
      (friendship.user_id == user.id || friendship.friend_id == user.id) && friendship.accepted == accepted
    end.nil?
  end
end
