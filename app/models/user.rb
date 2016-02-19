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
  
  def not_friends_with?(friend_id)
    friendships.where(friend_id: friend_id).count < 1 ## if not show up at least once, doesn't exist
  end
  
  def except_current_user(users)
    users.reject {|user| user.id == self.id} ## return collection without the current user
  end
  
  def self.search(param)
    # debugger
    return User.none if param.blank?
    
    param.strip!
    param.downcase!
    (username_matches(param) + email_matches(param)).uniq
    ##(first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    ##must define thsese methods, object oriented programming, outsource parts of it
  end
  
  def self.username_matches(param)
    
    matches('username', param)
  end
  
  # def self.last_name_matches(param)
  #   matches('last_name',param)
  # end
  
  def self.email_matches(param)
    matches('email', param)
  end
  
  def self.matches(field_name, param) ## query db
    where("lower(#{field_name}) like ?", "%#{param}%")
    ##% is wild card, so doesn't ahve to be exact match
  end
  
  
end