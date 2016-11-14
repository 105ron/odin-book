class User < ApplicationRecord
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, :dependent => :destroy
  #has_many :friends, :through => :friendships, :source => :user 
  # Access friends through custom search below


  # Scopes not used but left in case controllers require them 
  scope :pending_requests,  -> (user = nil){ Friendship.where(user_id: user, is_pending: true) }
  scope :confirmed_friends, -> (user = nil){ Friendship.where(user_id: user, confirmed: true) }

  # Devise settings
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable #omniauthable for facebook signups


  # Email validation
  validates :email, presence: true, length: { maximum: 255 },
            uniqueness: { case_sensitive: false }
 

  # Returns list of other users with relationship status to render users#index page
  def users_list
    User.joins("users left OUTER JOIN friendships ON 
                users.id = friendships.friend_id AND 
                friendships.user_id = #{self.id} WHERE users.id != #{self.id}")
                .select("users.*, friendships.confirmed")
                .order(:last_name)
  end


  # Find users friendship that are awaiting approval
  def pending_friends
    User.joins("INNER JOIN friendships ON users.id = friend_id WHERE 
                        friendships.user_id = #{self.id} AND 
                        friendships.is_pending = true")
  end


  def friends
    User.joins("INNER JOIN friendships ON users.id = friend_id WHERE 
                        friendships.user_id = #{self.id} AND 
                        friendships.confirmed = true")
  end


  def request_friendship(other_user)
    friendships.create(friend_id: other_user.id)
  end


  def accept_friendship(other_user)
    friendship = find_friendship(self.id, other_user.id)
    friendship.update(is_pending: false, confirmed:true) unless friendship.nil? #prevent possible errors
  end


  def destroy_friendship(other_user)
    friendship = find_friendship(self.id, other_user.id)
    friendship.destroy unless friendship.nil? #prevent possible errors
  end


  def find_friendship(user, other_user)
    friendship = Friendship.find_by(user_id: user, friend_id: other_user)
  end


  def feed
    friends_ids = "SELECT friend_id FROM friendships WHERE  
                        user_id = :user_id AND confirmed = true"
    Post.where("user_id IN (#{friends_ids}) OR user_id = :user_id", user_id: self.id)
  end


  # Returns true if the current user needs to accept friendship of other user.
  def pending_friendship?(other_user)
    pending_friends.include?(other_user)
  end


  # Returns true if the current user is following the other user.
  def friends?(other_user)
    friends.include?(other_user)
  end

  # For sign in and creating user with omniauth-facebook through devise
	def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
                          provider:auth.provider,
                          uid:auth.uid,
                          email:auth.info.email,
                          first_name: auth.info.first_name,
                          last_name: auth.info.last_name,
                          password:Devise.friendly_token[0,20],
                        )
      end    
    end
  end

end
