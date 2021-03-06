# == Schema Information <- te komentarze mamy dzieki dodaniu
 
# group :development do
  # gem 'annotate', '2.5.0'
# end 
# do gemfile

#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  # wydaje mi sie, ze tutaj ustalamy jakie pola/metody z ActiveRecord sa dostepne dla obiektow klasy User 
  
  has_secure_password
  has_many :microposts, dependent: :destroy
  # it arranges for the dependent microposts (i.e., the ones belonging to the given user) to be destroyed when the user itself is destroyed. 
  # This prevents userless microposts from being stranded in the database when admins choose to remove users from the system.  
  
    
  #before_save { |user| user.email = email.downcase }
  before_save { email.downcase! }
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 } #sprawdza atrybut name, ktory nie powinien byc pusty
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy  
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower  
  
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    #Micropost.where("user_id = ?", id)
    # ensures that id is properly escaped before being included in the underlying SQL query, thereby avoiding a serious security hole 
    # called SQL injection. The id attribute here is just an integer, so there is no danger in this case, but always escaping variables 
    # injected into SQL statements is a good habit to cultivate.
    
    Micropost.from_users_followed_by(self) # 'from_users_followed_by' jest zdefiniowane w 'micropost.rb'    

  end
  
  def following?(other_user) # to jest definicja metody 'following?', ktora jest uzywana w '_follow_form'
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private
  # sekcja, ktora bedzie widoczna tylko wewnetrznie przez model User
  

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
      
      #Using self ensures that assignment sets the user’s remember_token so that it will be written to the database 
      #along with the other attributes when the user is saved.      
    end
end
