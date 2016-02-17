class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name =>'User'## friend is class user
end
