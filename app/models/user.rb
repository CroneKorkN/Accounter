class User < ActiveRecord::Base
  has_secure_password  
  
  has_one :member
  
  delegate :name,
           :email,
           :password_digest,
           to: :member
end
