class Friendship < ApplicationRecord
	belongs_to :user, :foreign_key => :friend_id
  
  #after friendship created, create the inverse friendship in the table
  #But first check if this relationship has already been created by this method
  after_create do |u|
    if !Friendship.find_by(user_id: u.friend_id, friend_id: u.user_id)
      Friendship.create!(:user_id => u.friend_id, :friend_id => u.user_id)
    end
  end
  after_update do |p|
    reciprocal = Friendship.find_by(user_id: u.friend_id, friend_id: u.user_id)
    reciprocal.confirmed = self.confirmed unless reciprocal.nil? #don't run if no record found
  end
  after_destroy do |u|
    reciprocal = Friendship.find_by(user_id: u.friend_id, friend_id: u.user_id)
    reciprocal.destroy unless reciprocal.nil?
  end
end
