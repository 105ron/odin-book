### USERS ###
	#me
	rhys = User.new(email: 'rhys@rails.org',
	             first_name: 'Rhys',
	             last_name: 'Rails',
	             password: 'password',
	             password_confirmation: 'password')
	rhys.skip_confirmation!
	rhys.save!


	#my friend
	friend = User.new(email: 'friend@rails.org',
		              first_name: 'Nice',
		              last_name: 'Guy',
		              password: 'password',
		              password_confirmation: 'password')
	friend.skip_confirmation!
	friend.save!


	#A friend I don't like (unconfirmed friend request)
	non_friend = User.new(email: 'notafriend@rails.org',
	             	  first_name: 'Nota',
	             		last_name: 'Friend',
	             		password: 'password',
	             		password_confirmation: 'password')
	non_friend.skip_confirmation!
	non_friend.save!


	17.times do |n|
		email 			= Faker::Internet.email
	  first_name  = Faker::Name.first_name
	  last_name   = Faker::Name.last_name
	  password    = "password"
		user = User.new(email: email,
		             	  first_name: first_name,
		             		last_name: last_name,
		             		password: 'password',
		             		password_confirmation: 'password')
		user.skip_confirmation!
		user.save!
	end

	random_friend = User.find(5)

### FRIENDSHIPS ###
	#Two friendships, two awaiting approval and two pending friendships for Rhys
	Friendship.create!(user_id: rhys.id, friend_id: friend.id)
	inverse_friends = Friendship.find_by(user_id: friend.id, friend_id: rhys.id)
	inverse_friends.update(confirmed: true, is_pending: false)
	 

	Friendship.create!(user_id: rhys.id, friend_id: random_friend.id)
	#find other side of relationship and approve pending friendship
	random_inverse_friends = Friendship.find_by(user_id: random_friend.id, friend_id: rhys.id)
	random_inverse_friends.update(confirmed: true, is_pending: false)


	#two proposed friendships awaiting non_friends approval
	Friendship.create!(user_id: rhys.id, friend_id: 6)

	
	Friendship.create!(user_id: rhys.id, friend_id: 7)


	#two proposed friendship awaiting Rhys' approval
	Friendship.create!(user_id: non_friend.id, friend_id: rhys.id)


	Friendship.create!(user_id: 9, friend_id: rhys.id)


### POSTS ###
#Each user has 15 posts
users = User.all
15.times do |n|
	users.each do |user|
	  content = Faker::Lorem.sentence(45)
	  user.posts.create!(content: content, created_at: n.hours.ago)
	end
end

# create some comments and like posts for confirmed friends
users = [rhys,friend,random_friend]
users.each do |user|
	users.each do |poster|
		4.times do |n|
			comments = ["I'll drink a #{Faker::Beer.name} to that!", 
								 Faker::ChuckNorris.fact,
								 Faker::StarWars.quote,
								 "I'm going to complain to #{Faker::Commerce.department}",
								 "I just finished reading #{Faker::Book.title}, great read!",
								 Faker::Hipster.sentence,
								 "I just saw #{Faker::GameOfThrones.character}"] 
			user.posts[n].comments.create!(content: comments.sample, user_id: poster.id, created_at: n.minutes.ago)
			user.posts[n].likes.create!(user_id: poster.id)
		end
	end
end

	
