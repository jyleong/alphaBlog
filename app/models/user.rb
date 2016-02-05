class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 25}
  
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,uniqueness: {case_sensitive: false}, length: {minimum: 12, maximum: 40},
            format: {with: VALID_EMAIL_REGEX}
  ##regex ceck for email format
end