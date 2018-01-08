class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
   has_many :friend_requests, dependent: :destroy
   has_many :pending_friends, through: :friend_requests, source: :friend #look for friend_id in Friendrequests
   #has_many :accept_requests, class_name: "FriendRequest", foreign_key: "friend_id", dependent: destroy
   #has_many :accept_friends, through: :accept_friends, 

   has_many :posts
   has_many :friendships, dependent: :destroy
   has_many :friends, through: :friendships

   def remove_friend(friend)
    friends.destroy(friend)
  end
  def feed
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id)
  end
end
