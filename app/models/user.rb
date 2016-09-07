require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  property :password_hash, String

  def password=(password)
    self.password_hash = BCrypt::Password.create(password)
  end

end
