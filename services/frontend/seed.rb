require 'mongoid'
require './models/library'

Mongoid.load!('config-mongoid.yml',:development)

# Create some users
User.delete_all

seed_users = [
  {
    :username=>'elijahc',
    :email=>'ejd.christensen@gmail.com',
    :password=>"$2a$10$0ws7d/2qxlM3lRGvv02TGOkQMueVxkS5Rsb.1VkbN2MQcK/l4EI1m",
    :admin=>true
  },
  {
    :username=>'kennyf',
    :email=>'kenneth.felsenstein@ucdenver.edu',
    :password=>"$2a$10$ye5i2Xqjb0wONrDzSyud0e5UQSeAP6ws/NTmd63ItNZERsaYwnEI.",
    :admin=>false
  },
  {
    :username=>'default',
    :email=>'',
    :password=>"$2a$10$wfYxdSu3azeazvHNpUOJYuGw9n7hasFdd71lfstQOFvBKPZMwGXsG",
    :admin=>false
  }
]

seed_users.each do |user_hash|
  use = User.new(user_hash)
  use.save
end
