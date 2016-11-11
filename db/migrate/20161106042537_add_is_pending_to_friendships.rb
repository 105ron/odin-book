class AddIsPendingToFriendships < ActiveRecord::Migration[5.0]
  def change
  	add_column :friendships, :is_pending, :boolean, null: false, default: false
  end
end
