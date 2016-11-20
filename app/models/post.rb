class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  default_scope -> { order(created_at: :desc) }


  validates :user_id, presence: true 
  validates :content, presence: true, length: { minimum: 5, maximum: 2048 }


  def like_post(user)
    likes.create(user_id: user.id)
  end


  def likes_users
    User.joins("INNER JOIN likes ON users.id = user_id WHERE 
                                likes.post_id = #{self.id}")
  end

end
