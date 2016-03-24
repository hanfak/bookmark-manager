require 'bcrypt'
require 'dm-validations'

class User

  include DataMapper::Resource

  attr_accessor :password_confirmation
  attr_reader :password


  property :id,       Serial
  property :email,    String, required: true#, format: :email_address
  property :password_hash, Text

  validates_confirmation_of :password
  validates_presence_of :email
  validates_format_of :email, as: :email_address
  validates_uniqueness_of :email

  def password=(password)
    @password = password
    self.password_hash = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password_hash) == password
      user
    else
      nil
    end
  end

end
