class Micropost < ActiveRecord::Base
  attr_accessible :content 
  # In the case of the Micropost model, there is only one attribute that needs to be editable through the web, namely, the content attribute, 
  # so we need to remove :user_id from the accessible list, as shown in Listing 10.7.
  
  belongs_to :user
    
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'microposts.created_at DESC'  
end
