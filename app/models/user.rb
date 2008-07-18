class User < ActiveRecord::Base
	require 'digest/sha1'

	validates_presence_of	:username, :firstname, :lastname, :email
  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
	validates_uniqueness_of	:username, :email
	
	attr_accessor :password_confirmation
	validates_confirmation_of :password

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
