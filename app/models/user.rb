class User < ApplicationRecord
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships, :source => :user


  # Devise settings
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable #omniauthable for facebook signups


  # Email validation
  validates :email, presence: true, length: { maximum: 255 },
            uniqueness: { case_sensitive: false }


  #For sign in and creating user with omniauth-facebook through devise
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
