class User < ActiveRecord::Base
  has_many :articles, dependent: :destroy ## if destryed will destory all its artiocles
  has_many :friendships
  has_many :friends, through: :friendships
  before_save {self.email = email.downcase} ## before user hits db, email gets lowercased
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 25}
  
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,uniqueness: {case_sensitive: false}, length: {minimum: 12, maximum: 40},
            format: {with: VALID_EMAIL_REGEX}
  ##regex ceck for email format
  has_secure_password
end