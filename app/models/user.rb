class User < ActiveRecord::Base
  has_one :member

  after_initialize :set_member

  def set_member
    return if not member
    
    has_secure_password
    delegate :name,
             :email,
             :password_digest,
             to: :member
  end
end
