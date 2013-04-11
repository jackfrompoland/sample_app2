class Micropost < ActiveRecord::Base
  attr_accessible :content 
  # In the case of the Micropost model, there is only one attribute that needs to be editable through the web, namely, the content attribute, 
  # so we need to remove :user_id from the accessible list, as shown in Listing 10.7.
  
  belongs_to :user
    
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'microposts.created_at DESC'
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
