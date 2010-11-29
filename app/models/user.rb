class User < ActiveRecord::Base
    has_attached_file :photo, 
                      :styles => {:thumb=> "60x60#", :small  => "320x600>" },
                      :default_url => "/images/wally_small.jpg",
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                      :path => "/:style/:filename"                      

    attr_accessor     :password
        attr_accessible     :name, :email, :about, :password, :password_confirmation, :photo, :institution, :occupation, :year, :skills, :contact
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    has_and_belongs_to_many :projects
    has_many :comments
    
    validates :name, :presence          => true,
              :length                   => { :maximum => 50}
                     
    validates :email, :presence         => true,
              :format                   => { :with => email_regex},
              :uniqueness               => { :case_sensitive => false} 
        
    validates :password, :presence     => true,
                         :confirmation => true, :on => :create

    before_save :encrypt_password     

    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end
    
    class << self
      def authenticate(email, submitted_password)
        user = find_by_email(email)
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
      end
      
      def authenticate_with_salt(id, cookie_salt) #Use cookie to find user
      	user = find_by_id(id)
      	(user && user.salt == cookie_salt) ? user : nil # If user exists and
      	     										 	# salt matches.
      end
    end

    private
       
      def encrypt(string)
       secure_hash("#{salt}--#{string}")
      end

      def make_salt
        secure_hash("#{Time.now.utc}--#{password}")
      end

      def encrypt_password
        self.salt = make_salt
        self.encrypted_password = encrypt(password)     
      end
        
      def secure_hash(string)
        Digest::SHA2.hexdigest(string)    
      end
end


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

