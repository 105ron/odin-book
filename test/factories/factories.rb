FactoryGirl.define do
  
  factory :user, aliases: [:poster, :commenter] do
    
    sequence :first_name do |n|
      "foobar#{n}"
    end
    last_name "on rails"
    sequence :email do |n|
      "foo#{n}@bar.com"
    end
    password "password"
    password_confirmation "password"
  end


  factory :post do
    user
    sequence :content do |n|
      "Making post number #{n}"
    end
    sequence :created_at do |n|
      n.weeks.ago
    end
  end


  factory :comment do
    user
    post
    sequence :content do |n|
      "Making comment number #{n}"
    end
    sequence :created_at do |n|
      n.hours.ago
    end
  end

  factory :like do
    user
    post
    sequence :created_at do |n|
      n.minutes.ago
    end
  end


end