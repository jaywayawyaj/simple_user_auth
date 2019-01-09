require 'data_mapper'
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :required => true
  property :password, BCryptHash

  # validates_length_of :password, :min => 6

  def self.authenticate(email, password)
    user = first(email: email)
    return nil unless user

    if user.password == password
      user
    else
      nil
    end
  end

end
