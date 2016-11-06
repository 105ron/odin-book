class Friendship < ApplicationRecord
	belongs_to :user, :foreign_key => :friend_id

  #Friendship table creates and maintains two rows for each friendship
  
  #after friendship created, create the inverse friendship in the table
  #and set is_pending to true to define requestee
  after_create do |u|
    if !Friendship.find_by(user_id: u.friend_id, friend_id: u.user_id)
      Friendship.create!(user_id: u.friend_id, friend_id: u.user_id, 
                         is_pending: true)  
    end
  end

  after_update do |u|
    reciprocal = Friendship.find_by(user_id: u.friend_id, friend_id: u.user_id)
    #prevent infite loop of updating two records
    unless reciprocal.confirmed == self.confirmed || reciprocal.nil? 
      reciprocal.confirmed = self.confirmed 
      reciprocal.save
    end
  end
  
  #delete the other side of friendship
  after_destroy do |u|
    reciprocal = Friendship.find_by(user_id: u.friend_id, friend_id: u.user_id)
    reciprocal.destroy unless reciprocal.nil?
  end
end
