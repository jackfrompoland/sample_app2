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
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
      
      #Using self ensures that assignment sets the user’s remember_token so that it will be written to the database 
      #along with the other attributes when the user is saved.      
    end
end
