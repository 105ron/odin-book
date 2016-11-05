### USERS ###
#me
user = User.new(email: 'rhys@rails.org',
             first_name: 'Rhys',
             last_name: 'Rails',
             password: 'password',
             password_confirmation: 'password')
user.skip_confirmation!
user.save!

#my friend
user = User.new(email: 'friend@rails.org',
	              first_name: 'Nice',
	              last_name: 'Guy',
	              password: 'password',
	              password_confirmation: 'password')
user.skip_confirmation!
user.save!

#A friend I don't like (unconfirmed friend request)
user = User.new(email: 'notafriend@rails.org',
             	  first_name: 'Nota',
             		last_name: 'Friend',
             		password: 'password',
             		password_confirmation: 'password')
user.skip_confirmation!
user.save!


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