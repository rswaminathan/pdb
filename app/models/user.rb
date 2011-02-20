class User < ActiveRecord::Base                  

  has_many :authorizations
  
  cattr_reader :per_page
  @@per_page = 10
  
    attr_accessor     :password
    attr_accessible     :name, :email, :password, :password_confirmation
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    has_one                 :profile
    has_and_belongs_to_many :projects
    has_many                :comments
    has_many                :likes
	has_many				:relationship_projects,			:foreign_key => :follower_id,
															:dependent => :destroy
	has_many				:relationship_users,			:foreign_key => :follower_id,
															:dependent => :destroy
	has_many				:projects_following,			:through => :relationship_projects,
															:source => :followed
	has_many				:users_following, 				:through => :relationship_users,
															:source => :followed
	has_many 				:reverse_relationship_users,	:foreign_key => :followed_id,
															:class_name => "RelationshipUser",
															:dependent => :destroy
	has_many				:followers,						:through => :reverse_relationship_users
    
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

    def to_param
      "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"      
    end
    
    def login_with_omniauth?
      return  true unless provider.nil?    
    end
    class << self
      def search_by_name(query)
       where("name like ?", "%#{query}%")
      end

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
	
	def following_user?(followed)
		relationship_users.find_by_followed_id(followed)
	end
	
	def self.create_from_hash!(hash)
		create(:name => hash['user_info']['name'])
	end
  
	#def total_following(user)
	#	flash[:L]=user.projects_following
	#	user.users_following.each do |i|
	#		flash[:L] += i.projects
	#	end
	#	flash[:L]
	#end
	
	def following_project?(followed)
		relationship_projects.find_by_followed_id(followed)
	end

	def follow_user!(followed)
		relationship_users.create!(:followed_id => followed.id)
	end
	
	def follow_project!(followed)
		relationship_projects.create!(:followed_id => followed.id)
	end
	
	def unfollow_user!(followed)
		relationship_users.find_by_followed_id(followed).destroy
	end	
	
	def unfollow_project!(followed)
		relationship_projects.find_by_followed_id(followed).destroy
	end
	
	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["user_info"]["name"]
			user.email = auth["extra"]["user_hash"]["email"].downcase
      user.facebook_token = auth["credentials"]["token"]
      user.password = auth["credentials"]["token"]
      user.create_profile
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
        if !password.nil?
          self.salt = make_salt
          self.encrypted_password = encrypt(password) 
        end    
      end
        
      def secure_hash(string)
        Digest::SHA2.hexdigest(string)    
      end
end




# == Schema Information
#
# Table name: users
#
#  id                 :integer         primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :timestamp
#  updated_at         :timestamp
#  encrypted_password :string(255)
#  salt               :string(255)
#

