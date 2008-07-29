class User < ActiveRecord::Base
	require 'digest/sha1'
	has_many :todolists
  SEX = ["Male", "Female"]
	validates_presence_of	:username, :firstname, :lastname, :email
  validates_format_of :password, 
                      :with => /^(\d)*([a-z])*(?=.*[A-Z])([\x20-\x7E]){6,14}$/,
                      :message => "should contain atleast one uppercase letter and one special character allowed with range between 6-14 characters",
                      :if => Proc.new { |u| !u.password.blank? }
  validates_format_of :username, 
                      :with => /^(\w){3,20}$/i,
                      :message => "should contain letters[a-z],digits[0-9] and underscore(_) allowed with range between 3-20 characters",
                      :if => Proc.new { |u| !u.username.blank? }

  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => "InValid",
                      :if => Proc.new { |u| !u.email.blank? }

	validates_uniqueness_of	:username, :email
	validates_confirmation_of	:password
	
	attr_accessor :password_confirmation

  def validate_on_create
      errors.add(:password, "cannot be blank") unless !password.blank?
  end

	def password
		@password
	end

	def password=(pwd)
		@password = pwd
		return if pwd.blank?
		create_new_salt
		self.hashed_password = User.encrypted_password(self.password, self.salt)
	end

	def self.authenticate(username, password)
		user = self.find_by_username(username)
		if user
			expected_password = encrypted_password(password, user.salt)
			if user.hashed_password != expected_password
				user = nil
			end
		end
		user
	end

  private

	def self.encrypted_password(password, salt)
		string_to_hash = 	password + "todolist" + salt
		Digest::SHA1.hexdigest(string_to_hash)
	end

	def create_new_salt
		self.salt = self.object_id.to_s + rand.to_s
	end
end
