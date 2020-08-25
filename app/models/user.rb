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
  # HARDCODING FOR THE FUL WEW
  has_many :reverse_friendships, foreign_key: :friend_id, class_name: 'Friendship'
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
  has_many :accepted_friendships,
          -> { where(accepted: true) },
          class_name: 'Friendship'
  
  def friend?(user, accepted = true)
    !friendships.find { |friendship| friendship.friend_id == user.id && friendship.accepted == accepted }.nil?
  end

  def timeline_posts
    Post.where(user_id: [id] + accepted_friendships.pluck('friend_id'))
  end
end
