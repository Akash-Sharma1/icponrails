class User < ApplicationRecord
    validates :username, :email, presence: true
    validates :email, uniqueness: true
    validates :username, uniqueness: true
    
    has_attached_file :resume
    validates_attachment_content_type :resume,
        :content_type => ['application/pdf', 'application/msword', 'text/plain'], :if => :resume_attached?,
        presence: true, :if => :user_is_a_participant?
    
    def resume_attached?
        self.resume?
    end
    
    def user_is_a_participant?
        return true if self.usertype == "participant"
    end

end

