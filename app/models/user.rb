class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :friend_requests, dependent: :destroy
   has_many :pending_friends, through: :friend_requests, source: :friend #look for friend_id in Friendrequests
   #has_many :accept_requests, class_name: "FriendRequest", foreign_key: "friend_id", dependent: destroy
   #has_many :accept_friends, through: :accept_friends, 

   has_many :posts
   has_many :likes
   has_many :comments
   has_many :friendships, dependent: :destroy
   has_many :friends, through: :friendships
   devise :omniauthable, omniauth_providers: %i[facebook]


   def remove_friend(friend)
    friends.destroy(friend)
  end
  def feed
    Post.where("user_id IN (?) OR user_id = ?", friend_ids, id)
  end
  def liked?(post)
    if self.likes.find_by(post_id: post.id)
      true
    else 
      false
    end
  end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    #user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails, 
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end
def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
def friends?(user)
  if self.friends.find_by(id: user.id)
    true
  else 
    false
  end
end
end
