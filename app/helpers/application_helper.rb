module ApplicationHelper

	def full_title(page_title = '')  
    base_title = "Odin-Book" 
    if page_title.empty?                              
      base_title                                      
    else
      page_title + " | " + base_title                 
    end
  end


  def find_friend_requests
    @friend_requests = current_user.pending_friends
  end
end
